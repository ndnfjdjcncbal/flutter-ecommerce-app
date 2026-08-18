import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/servises/Mysevice.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:firebase_auth/firebase_auth.dart' show GoogleAuthProvider, FirebaseAuth, UserCredential;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/datasource/auth/forgetpass/forgetpassword.dart';
import '../../data/datasource/auth/login.dart';
import '../../view/widget/widgetauth/Aweasomdialog.dart';
import '../../view/widget/widgetauth/widgetforgetpassword.dart';
import 'package:google_sign_in/google_sign_in.dart';
  abstract class logincontroller extends GetxController{
forgetpassword();
  loginf();
  gosignup();

}class loginimp extends
logincontroller{

  Future<UserCredential?> signInWithGoogle() async {
    try {
     statusRequest=StatusRequest.loading;
     update();
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId:
        '605835209253-esoeqvee85itm8vjfaas4o5mbul9gscg.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleUser =
      await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      await myServices.sharedPreferences.setString('google', 'go');

     statusRequest=StatusRequest.success;update();

      Get.offAllNamed(approute.homepage0);

      return userCredential;
    } catch (e) {

      // اقفل الـ loading لو مفتوح
     statusRequest=StatusRequest.failure;
     update();

      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

      return null;
    }
  }


  RxBool isEmailValid = false.obs;
  bool isshowpass =true;
  change(){

    isshowpass=isshowpass==true?false:true;
    update();
  }

  StatusRequest statusRequest=StatusRequest.none;
  late TextEditingController emailforgetpassword;
////////////////////////////////////////////////////
  late TextEditingController email;
  late TextEditingController password;
  Myservice myServices = Get.find();
  late forgetpassdata verfilog;

  GlobalKey<FormState> formstatelogin = GlobalKey<FormState>();
  GlobalKey<FormState> formstatelforgetpass = GlobalKey<FormState>();

  late  Logindata login;
  @override
  loginf()async {
    if(formstatelogin.currentState!.validate()){
      statusRequest=StatusRequest.loading;
      update();
      var response =await login.loginf(email.text, password.text);
      print(response);
      if(response['status']=='success'){
        statusRequest=StatusRequest.success;
        update();
        myServices.sharedPreferences.setString('Step', '1');
        myServices.sharedPreferences.setString(
          "id",
          response['data']['id'],
        );

        Get.offAllNamed(approute.homepage0);
      }else{
        if(response["status"]=="failure"){
          statusRequest=StatusRequest.failure;
          update();
          WarningDialog(
            title: 'Error',
            desc: 'username or password wrong',
            onOkPressed: () {
              Get.offAllNamed(approute.login); // offAll أحسن من toNamed
              update();
            },
            onCancelPressed: () {
              Get.toNamed(approute.login);
              update();
            },
          ).show();

      }}
      update();
    }


  }
@override
  void onInit() {
  verfilog=forgetpassdata((crud()));
  login = Logindata((crud()));
  emailforgetpassword=TextEditingController();

  email=TextEditingController();
    password=TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailforgetpassword.dispose();
    super.dispose();
  }

  @override
  gosignup() {
    Get.toNamed(approute.SignUp);
  }

  @override
  forgetpassword() {
    showModalBottomSheet(context: Get.context!,
        builder: (BuildContext context) {

      return  ForgetPasswordSheet(emailController: emailforgetpassword,formKey:
      formstatelforgetpass,isEmailValid:isEmailValid ,onPressed:  () async{
        statusRequest=StatusRequest.loading;
        update();
        var response=await verfilog.forgetpassf(emailforgetpassword.text);
        print(response);
        if(response['status']=='success'){
          statusRequest=StatusRequest.success;
          Get.toNamed(approute.verfiedcodelogin,arguments: {'email': emailforgetpassword.text,});


        }else{
          if(response['status']=='faluire'){
            statusRequest=StatusRequest.failure;
            update();
            WarningDialog(
              title: 'Error',
              desc: 'username or password wrong',
              onOkPressed: () {
                Get.offAllNamed(approute.login); // offAll أحسن من toNamed
                update();
              },
              onCancelPressed: () {
                Get.offAllNamed(approute.login); // offAll أحسن من toNamed

              },
            ).show();
          }

        }} );

    });


  }

}