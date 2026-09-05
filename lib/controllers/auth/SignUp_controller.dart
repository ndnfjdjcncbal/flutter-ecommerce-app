import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/auth/signup.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SignUpController extends GetxController {
  Future<void> signup();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isShowPassword = true;
  StatusRequest statusRequest = StatusRequest.none;

  late signuodata signData;
  final Myservice myServices = Get.find();

  void togglePasswordVisibility() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  Future<void> signup() async {
    if (!formState.currentState!.validate()) {
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    final response = await signData.signupf(
      name.text,
      email.text,
      password.text,
    );

    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      myServices.sharedPreferences.setString('Step', '2');
      update();

      Get.toNamed(approute.verfiedcode0, arguments: {'email': email.text});
      return;
    }

    if (response['status'] == 'failed') {
      statusRequest = StatusRequest.failure;
      update();

      AwesomeDialog(
        btnCancelColor: AppColors.primary,
        btnOkColor: AppColors.primary,
        context: Get.context!,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'لم يتم انشاء الحساب',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Get.toNamed(approute.login);
          update();
        },
      )..show();
    }

    update();
  }

  @override
  void onInit() {
    signData = signuodata(crud());
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
