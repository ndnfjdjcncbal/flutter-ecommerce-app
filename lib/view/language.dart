import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/localization/changelocal.dart';

class Language1 extends StatelessWidget {
  const Language1({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Changelocal>(
      builder: (controller) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 70),
                color: AppColors.primary,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () async {
                    controller.Changelocalf("ar");
                    await Get.toNamed(approute.onboarding);
                  },
                  child: Text("ar", style: TextStyle(color: AppColors.white)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 70),
                color: AppColors.primary,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () async {
                    controller.Changelocalf("en");
                    await Get.toNamed(approute.onboarding);
                  },
                  child: Text("en", style: TextStyle(color: AppColors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
