import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../data/datasource/auth/forgetpass/forgetpassword.dart';
import '../../view/widget/widgetauth/changepasswordbotomshet.dart';

abstract class verifiedcodelogin extends GetxController {
  checkcodelogf(String verif);
}

class verifiedimplogin extends verifiedcodelogin {
  StatusRequest statusRequest = StatusRequest.none;
  late TextEditingController pass1;
  late TextEditingController pass2;
  bool isshowpass = true;

  change() {
    isshowpass = isshowpass == true ? false : true;
  }

  GlobalKey<FormState> formstatel4 = GlobalKey<FormState>();

  late forgetpassdata check;

  @override
  checkcodelogf(verif) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await check.checkcodelogin(email1!, verif);
    print(response);
    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      update();
      showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: Get.context!,
        builder: (context) => ChangePasswordSheet(
          onTapl: () {
            change();
          },
          obscureText: isshowpass,
          formstatel2: formstatel4,
          pass1: pass1,
          pass2: pass2,
          statusRequest: statusRequest,
          onSubmit: (p1, p2) async {
            statusRequest = StatusRequest.loading;
            update();
            var response = await check.resetpassf(email1!, p1);
            if (response['status'] == 'success') {
              statusRequest = StatusRequest.success;
              update();
              Navigator.pop(context);
              Get.offAllNamed(approute.login);
            } else {
              statusRequest = StatusRequest.failure;
              update();
              Get.defaultDialog(
                title: "Error",
                middleText: "فشل تغيير كلمة المرور، حاول مرة أخرى",
              );
            }
          },
        ),
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

  String? email1;
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
    pass2 = TextEditingController();
    pass1 = TextEditingController();
    check = forgetpassdata(crud());
    email1 = Get.arguments['email'];
    super.onInit();
  }

  @override
  void dispose() {
    pass1.dispose();
    pass2.dispose();
    super.dispose();
  }
}
