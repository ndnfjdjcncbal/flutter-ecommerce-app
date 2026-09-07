import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/core/function/authvalidator/validator.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/auth/login_controller.dart';
import '../widget/auth/signinwith.dart';
import '../widget/auth/textfieldauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LoginControllerImp>()) {
      Get.put(LoginControllerImp());
    }

    final myservice = Get.find<Myservice>();
    final sharedPrefLang = myservice.sharedPreferences.getString('lang');
    final controller = Get.find<LoginControllerImp>();

    return Scaffold(
      body: GetBuilder<LoginControllerImp>(
        builder: (controllerBuilder) => Handlingdataview(
          statusRequest: controllerBuilder.statusRequest,
          widget1: _buildLoadingState(sharedPrefLang),
          widget: Form(
            key: controllerBuilder.loginFormKey,
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                Column(
                  crossAxisAlignment: sharedPrefLang == 'ar'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    _buildTitle(),
                    const SizedBox(height: 10),
                    _buildSubtitle(),
                    const SizedBox(height: 37),
                    _buildLabel('Email or phone number'),
                    const SizedBox(height: 10),
                    textfieldauth(
                      hintText: '14'.tr,
                      suffixIcon: const Icon(Icons.email_outlined),
                      validator: (val) => validinput(val!, 13, 40, 'email'),
                      controller: controllerBuilder.email,
                    ),
                    const SizedBox(height: 15),
                    _buildLabel('Password'),
                    const SizedBox(height: 16),
                    textfieldauth(
                      hintText: '16'.tr,
                      suffixIcon: const Icon(Icons.lock_outlined),
                      validator: (val) => validinput(val!, 8, 30, '15'.tr),
                      controller: controllerBuilder.password,
                      obscureText: controllerBuilder.isShowPassword,
                      onTap: controllerBuilder.togglePasswordVisibility,
                    ),
                    const SizedBox(height: 13),
                    _buildForgotPasswordButton(
                      isArabic: sharedPrefLang == 'ar',
                      onPressed: controllerBuilder.forgetpassword,
                    ),
                    const SizedBox(height: 20),
                    _buildLoginButton(controllerBuilder),
                    const SizedBox(height: 19),
                    _buildDividerText('18'.tr),
                    const SizedBox(height: 12),
                    signiniwth(
                      icon: const FaIcon(FontAwesomeIcons.google),
                      text: '19'.tr,
                      onPressed: controllerBuilder.signInWithGoogle,
                    ),
                    const SizedBox(height: 12),
                    signiniwth(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      text: '20'.tr,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    _buildSignupPrompt(controllerBuilder),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(String? sharedPrefLang) {
    return Skeletonizer(
      enabled: true,
      child: Form(
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            Column(
              crossAxisAlignment: sharedPrefLang == 'ar'
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Bone.text(width: 150),
                const SizedBox(height: 10),
                const Bone.text(words: 6),
                const SizedBox(height: 37),
                Bone.text(width: 150),
                const SizedBox(height: 10),
                Bone(
                  height: 55,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 15),
                Bone.text(width: 70),
                const SizedBox(height: 16),
                Bone(
                  height: 55,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 13),
                Bone.text(width: 120),
                const SizedBox(height: 20),
                Center(
                  child: Bone(
                    width: 220,
                    height: 55,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                const SizedBox(height: 19),
                Center(child: Bone.text(width: 170)),
                const SizedBox(height: 12),
                Bone(
                  width: double.infinity,
                  height: 50,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 12),
                Bone(
                  width: double.infinity,
                  height: 50,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 20),
                Center(child: Bone.text(width: 220)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '11'.tr,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'Please login with registered account',
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildForgotPasswordButton({
    required bool isArabic,
    required VoidCallback onPressed,
  }) {
    return Align(
      alignment: isArabic ? Alignment.centerLeft : Alignment.centerRight,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          '17'.tr,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginControllerImp controller) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primary,
        ),
        child: MaterialButton(
          onPressed: controller.loginf,
          child: Text('9'.tr, style: const TextStyle(color: AppColors.white)),
        ),
      ),
    );
  }

  Widget _buildDividerText(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12.2),
      ),
    );
  }

  Widget _buildSignupPrompt(LoginControllerImp controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('21'.tr, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        GestureDetector(
          onTap: controller.gosignup,
          child: Text(
            '22'.tr,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
