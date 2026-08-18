import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/auth/SignUp_controller.dart';
import '../../core/function/authvalidator/validator.dart';
import '../widget/widgetauth/signinwith.dart';
import '../widget/widgetauth/textfieldauth.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    signuoimp controller = Get.put(signuoimp());

    return Scaffold(
      body: GetBuilder<signuoimp>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusrequest1,
          widget: Form(
            key: controller.formstates,

            child: ListView(
              padding: EdgeInsets.all(14),

              children: [
                SizedBox(height: 60),
                Text(
                  "22".tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  "Staret learning with creat your acccount account ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 30),
                Text(
                  " Username ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                textfieldauth(
                  hintText: "23".tr,
                  suffixIcon: Icon(Icons.person_2_outlined),
                  validator: (val) => validinput(val!, 6, 20, '39'.tr),
                  controller: controller.name,
                ),
                SizedBox(height: 15),

                Text(
                  "40".tr,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 16),
                textfieldauth(
                  hintText: "14".tr,
                  suffixIcon: Icon(
                    Icons.lock_outlined,
                    color: Color(0xfff5f5f22),
                  ),
                  validator: (val) => validinput(val!, 6, 30, '41'.tr),
                  controller: controller.email,
                ),

                SizedBox(height: 10),

                Text(
                  "15".tr,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                textfieldauth(
                  hintText: "16".tr,
                  suffixIcon: Icon(
                    Icons.lock_outlined,
                    color: Color(0xfff5f5f22),
                  ),
                  validator: (val) => validinput(val!, 4, 40, '15'.tr),
                  controller: controller.password,
                  obscureText: controller.isshowpass,
                  onTap: () {
                    controller.change();
                  },
                ),

                SizedBox(height: 20),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primary,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        controller.Signup();
                      },
                      child: Text(
                        '22'.tr,
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 19),
                Center(
                  child: Text(
                    "18".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12.2,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                signiniwth(
                  icon: FaIcon(FontAwesomeIcons.google),
                  text: "19".tr,
                ),
                SizedBox(height: 10),
                signiniwth(
                  icon: FaIcon(FontAwesomeIcons.facebook),
                  text: '20'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
