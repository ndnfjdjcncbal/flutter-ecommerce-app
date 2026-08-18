import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import '../../../core/counstant/colore.dart';

class WarningDialog {
  final String title;
  final String desc;
  final VoidCallback onOkPressed;
  final VoidCallback onCancelPressed;

  WarningDialog({
    required this.title,
    required this.desc,
    required this.onOkPressed,
    required this.onCancelPressed,
  });

  void show() {
    AwesomeDialog(
      context: Get.context!,
      btnCancelColor: AppColors.primary,
      btnOkColor: AppColors.primary,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkOnPress: onOkPressed,
      btnCancelOnPress: onCancelPressed,
    )..show();
  }
}