import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../controller/auth/verifiedcodeloginn.dart';
import '../widget/materialbutton.dart';

class Verfiedcodelogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    verifiedimplogin controller = Get.put(verifiedimplogin());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 70.3,
        shape: Border(bottom: BorderSide(color: AppColors.black, width: 1)),
        backgroundColor: AppColors.white,
        title: Text("47".tr),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: GetBuilder<verifiedimplogin>(
              builder: (controller) => Handlingdataview(
                statusRequest: controller.statusRequest,
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 9),
                    Center(
                      child: ClipRRect(child: Image.asset("assets/verfi.png")),
                    ),
                    SizedBox(height: 19),
                    Text(
                      "42".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "43".tr,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 9),
                    Text(
                      "ik8043873@gmail.com",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    Pinput(
                      length: 5,
                      defaultPinTheme: controller.defaultPinTheme,
                      focusedPinTheme: controller.focusedPinTheme,
                      onCompleted: (pin) {
                        controller.checkcodelogf(pin);
                        print('الكود: $pin');
                      },
                    ),
                    SizedBox(height: 50),
                    Materialbutton(text: '44'.tr, onPressed: () {}),
                    SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 26),
                          child: Row(
                            children: [
                              Text(
                                "46".tr,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
