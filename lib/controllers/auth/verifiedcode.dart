import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/data/data_sources/auth/verifiedcodesignuo/verifiedcodesignuo.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

abstract class VerifiedCodeController extends GetxController {
  Future<void> verifyCode(String verif);
  Future<void> resendCode();
}

class VerifiedCodeControllerImp extends VerifiedCodeController {
  StatusRequest statusRequest = StatusRequest.none;

  late verfiecodes verificationData;
  String? email;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 20,
      color: AppColors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primary),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  late final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.primary),
    borderRadius: BorderRadius.circular(13),
  );

  late final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ),
  );

  @override
  Future<void> verifyCode(String verif) async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await verificationData.verfiecodef(email ?? '', verif);

    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      update();

      showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: Get.context!,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 15),
                Image.asset('assets/Capture.png'),
                const Text(
                  'Register Success',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const Text(
                  'Congratulation! your account already created.',
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                const Text(
                  'please login to get mazing experience.',
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Get.toNamed(approute.login);
                    },
                    child: const Text('Go to HomePage'),
                  ),
                ),
              ],
            ),
          );
        },
      );
      update();
      return;
    }

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
        desc: 'لم يتم التحقق من الحساب',
        btnCancelOnPress: () {
          Get.toNamed(approute.verfiedcode0);
          update();
        },
        btnOkOnPress: () {
          statusRequest = StatusRequest.loading;
          Get.toNamed(approute.SignUp);
          update();
        },
      )..show();
    }

    update();
  }

  @override
  Future<void> resendCode() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await verificationData.resendcode(email ?? '');

    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      Get.defaultDialog(title: 'Verified done!');
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

  @override
  void onInit() {
    verificationData = verfiecodes(crud());
    email = Get.arguments?['email'];
    super.onInit();
  }
}
