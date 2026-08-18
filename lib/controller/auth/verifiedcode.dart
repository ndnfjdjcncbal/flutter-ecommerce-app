import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../data/datasource/auth/verifiedcodesignuo/verifiedcodesignuo.dart';

abstract class verifiedcode extends GetxController {
  verfiecode(String verif);

  resendcodeff();
}

class verifiedimp extends verifiedcode {
  StatusRequest statusRequest = StatusRequest.none;

  late verfiecodes verfi;

  @override
  verfiecode(verif) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verfi.verfiecodef(email!, verif);
    print(response);
    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      update();
      showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: Get.context!,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 15),
                Image.asset("assets/Capture.png"),
                Text(
                  "Register Success",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  "Congratulation! your account already created.",
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                Text(
                  "please login to get mazing experience.",
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                SizedBox(height: 40),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Get.toNamed(approute.login);
                    },
                    child: Text("Go to HomePage"),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      if (response['status'] == 'falire') {
        statusRequest = StatusRequest.failure;
        update();
        AwesomeDialog(
          btnCancelColor: AppColors.primary,
          btnOkColor: AppColors.primary,
          context: Get.context!,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'لم يتم التحقق من  الحساب',
          btnCancelOnPress: () {
            Get.toNamed(approute.verfiedcode0);
            update();
          },
          btnOkOnPress: () async {
            statusRequest = StatusRequest.loading;
            Get.toNamed(approute.SignUp);
            update();
          },
        )..show();
      }
    }
    update();
  }

  resendcodeff() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verfi.resendcode(email!);
    print(response);
    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      Get.defaultDialog(title: "Verified done!");
    } else {
      statusRequest = StatusRequest.failure;
      Get.defaultDialog(
        onConfirm: () {
          Get.toNamed(approute.verfiedcode0);
        },
      );
    }
    update();
  }

  String? email;
  late final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.primary),
    borderRadius: BorderRadius.circular(13),
  );

  late final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: Color.fromRGBO(234, 239, 243, 1),
    ),
  );
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(
      fontSize: 20,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primary),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  void onInit() {
    verfi = verfiecodes((crud()));
    email = Get.arguments['email'];
    super.onInit();
  }
}
