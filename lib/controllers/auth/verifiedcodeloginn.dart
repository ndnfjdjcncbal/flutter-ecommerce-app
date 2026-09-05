import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/data/data_sources/auth/forgetpass/forgetpassword.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../view/widget/auth/changepasswordbotomshet.dart';

abstract class VerifiedCodeLoginController extends GetxController {
  Future<void> checkCodeLogin(String verif);
}

class VerifiedCodeLoginControllerImp extends VerifiedCodeLoginController {
  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController pass1;
  late TextEditingController pass2;
  bool isShowPassword = true;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late forgetpassdata check;
  String? email;

  void togglePasswordVisibility() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  Future<void> checkCodeLogin(String verif) async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await check.checkcodelogin(email ?? '', verif);

    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      update();

      showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: Get.context!,
        builder: (context) => ChangePasswordSheet(
          onTapl: togglePasswordVisibility,
          obscureText: isShowPassword,
          formstatel2: formState,
          pass1: pass1,
          pass2: pass2,
          statusRequest: statusRequest,
          onSubmit: (p1, p2) async {
            statusRequest = StatusRequest.loading;
            update();

            final resetResponse = await check.resetpassf(email ?? '', p1);

            if (resetResponse['status'] == 'success') {
              statusRequest = StatusRequest.success;
              update();
              Navigator.pop(context);
              Get.offAllNamed(approute.login);
              return;
            }

            statusRequest = StatusRequest.failure;
            update();
            Get.defaultDialog(
              title: 'Error',
              middleText: 'فشل تغيير كلمة المرور، حاول مرة أخرى',
            );
          },
        ),
      );
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
  void onInit() {
    pass2 = TextEditingController();
    pass1 = TextEditingController();
    check = forgetpassdata(crud());
    email = Get.arguments?['email'];
    super.onInit();
  }

  @override
  void dispose() {
    pass1.dispose();
    pass2.dispose();
    super.dispose();
  }
}
