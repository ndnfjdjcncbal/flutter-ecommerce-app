import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:ecommerce/core/function/authvalidator/validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/auth/login_controller.dart';
import '../../core/servises/Mysevice.dart';
import '../widget/widgetauth/signinwith.dart';
import '../widget/widgetauth/textfieldauth.dart';

class Login extends StatelessWidget {
  final myservice = Get.find<Myservice>();
  late String? sharedPrefLang = myservice.sharedPreferences.getString("lang");

  Widget build(BuildContext context) {
    loginimp controlle0 = Get.put(loginimp());
    return Scaffold(
      body: GetBuilder<loginimp>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formstatelogin,
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                Column(
                  crossAxisAlignment: sharedPrefLang == 'ar'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      "11".tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Please login with registired account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 37),
                    const Text(
                      "Email or phone number",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    textfieldauth(
                      hintText: "Enter Your email or phone number",
                      suffixIcon: const Icon(Icons.email_outlined),
                      validator: (val) => validinput(val!, 13, 40, "email"),
                      controller: controller.email,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    textfieldauth(
                      hintText: "Create your password",
                      suffixIcon: Icon(Icons.lock_outlined),
                      validator: (val) => validinput(val!, 8, 30, "15".tr),
                      controller: controller.password,
                      obscureText: controller.isshowpass,
                      onTap: () {
                        controller.change();
                      },
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            controller.forgetpassword();
                          },
                          child: const Text(
                            "? Forget Password",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 110,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.primary,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            controller.loginf();
                          },
                          child: Text(
                            '9'.tr,
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 19),
                    Center(
                      child: Text(
                        "18".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    signiniwth(
                      icon: const FaIcon(FontAwesomeIcons.google),
                      text: "19".tr,
                      onPressed: () {
                        controller.signInWithGoogle();
                      },
                    ),
                    const SizedBox(height: 12),
                    signiniwth(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      text: "20".tr,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "21".tr,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.gosignup();
                          },
                          child: Text(
                            "22".tr,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
