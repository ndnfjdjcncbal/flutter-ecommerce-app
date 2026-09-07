import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/auth/forgetpass/forgetpassword.dart';
import 'package:ecommerce/data/data_sources/auth/login.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:ecommerce/view/widget/auth/Aweasomdialog.dart';
import 'package:ecommerce/view/widget/auth/widgetforgetpassword.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, GoogleAuthProvider, UserCredential;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginController extends GetxController {
  void forgetpassword();
  Future<void> loginf();
  void gosignup();
}

class LoginControllerImp extends LoginController {
  final Myservice myServices = Get.find();

  RxBool isEmailValid = false.obs;
  bool isShowPassword = true;
  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController emailForgetPassword;
  late TextEditingController email;
  late TextEditingController password;

  late forgetpassdata forgetPasswordData;
  late Logindata loginData;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isShowPassword = !isShowPassword;
    update();
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId:
            '605835209253-esoeqvee85itm8vjfaas4o5mbul9gscg.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      await myServices.sharedPreferences.setString('google', 'go');
      statusRequest = StatusRequest.success;
      update();

      Get.offAllNamed(approute.homepage0);
      return userCredential;
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();

      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  @override
  Future<void> loginf() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    final response = await loginData.loginf(email.text, password.text);

    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      myServices.sharedPreferences.setString('Step', '1');
      myServices.sharedPreferences.setString('id', response['data']['id']);
      update();

      Get.offAllNamed(approute.homepage0);
      return;
    }

    if (response['status'] == 'failure') {
      WarningDialog(
        title: 'Error',
        desc: 'username or password wrong',
        onOkPressed: () {
          Get.offAllNamed(approute.login);
          update();
        },
        onCancelPressed: () {
          Get.offAllNamed(approute.login);
          update();
        },
      ).show();
    }

    update();
  }

  @override
  void onInit() {
    forgetPasswordData = forgetpassdata(crud());
    loginData = Logindata(crud());
    emailForgetPassword = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailForgetPassword.dispose();
    super.dispose();
  }

  @override
  void gosignup() {
    Get.toNamed(approute.SignUp);
  }

  @override
  void forgetpassword() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return ForgetPasswordSheet(
          emailController: emailForgetPassword,
          formKey: forgetPasswordFormKey,
          isEmailValid: isEmailValid,
          onPressed: () async {
            statusRequest = StatusRequest.loading;
            update();

            final response = await forgetPasswordData.forgetpassf(
              emailForgetPassword.text,
            );

            if (response['status'] == 'success') {
              statusRequest = StatusRequest.success;
              Get.toNamed(
                approute.verfiedcodelogin,
                arguments: {'email': emailForgetPassword.text},
              );
              return;
            }

            if (response['status'] == 'faluire') {
              update();

              WarningDialog(
                title: 'Error',
                desc: 'username or password wrong',
                onOkPressed: () {
                  Get.offAllNamed(approute.login);
                  update();
                },
                onCancelPressed: () {
                  Get.offAllNamed(approute.login);
                },
              ).show();
            }
          },
        );
      },
    );
  }
}
