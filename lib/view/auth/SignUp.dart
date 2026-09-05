import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/core/function/authvalidator/validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/auth/SignUp_controller.dart';
import '../widget/auth/signinwith.dart';
import '../widget/auth/textfieldauth.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SignUpControllerImp>()) {
      Get.put(SignUpControllerImp());
    }

    final controller = Get.find<SignUpControllerImp>();

    return Scaffold(
      body: GetBuilder<SignUpControllerImp>(
        builder: (controllerBuilder) => Handlingdataview(
          statusRequest: controllerBuilder.statusRequest,
          widget1: _buildLoadingState(),
          widget: Form(
            key: controllerBuilder.formState,
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                const SizedBox(height: 60),
                _buildTitle(),
                const SizedBox(height: 10),
                _buildSubtitle(),
                const SizedBox(height: 30),
                _buildLabel('Username'),
                const SizedBox(height: 10),
                textfieldauth(
                  hintText: '23'.tr,
                  suffixIcon: const Icon(Icons.person_2_outlined),
                  validator: (val) => validinput(val!, 6, 20, '39'.tr),
                  controller: controllerBuilder.name,
                ),
                const SizedBox(height: 15),
                _buildLabel('40'.tr),
                const SizedBox(height: 16),
                textfieldauth(
                  hintText: '14'.tr,
                  suffixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xfff5f5f22),
                  ),
                  validator: (val) => validinput(val!, 6, 30, '41'.tr),
                  controller: controllerBuilder.email,
                ),
                const SizedBox(height: 10),
                _buildLabel('15'.tr),
                const SizedBox(height: 10),
                textfieldauth(
                  hintText: '16'.tr,
                  suffixIcon: const Icon(
                    Icons.lock_outlined,
                    color: Color(0xfff5f5f22),
                  ),
                  validator: (val) => validinput(val!, 4, 40, '15'.tr),
                  controller: controllerBuilder.password,
                  obscureText: controllerBuilder.isShowPassword,
                  onTap: controllerBuilder.togglePasswordVisibility,
                ),
                const SizedBox(height: 20),
                _buildCreateAccountButton(controllerBuilder),
                const SizedBox(height: 19),
                _buildDividerText('18'.tr),
                const SizedBox(height: 10),
                signiniwth(
                  icon: const FaIcon(FontAwesomeIcons.google),
                  text: '19'.tr,
                ),
                const SizedBox(height: 10),
                signiniwth(
                  icon: const FaIcon(FontAwesomeIcons.facebook),
                  text: '20'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const SizedBox(height: 60),
          Bone.text(words: 2, width: 150),
          const SizedBox(height: 10),
          Bone.text(words: 6, width: 280),
          const SizedBox(height: 30),
          Bone.text(words: 2, width: 90),
          const SizedBox(height: 10),
          Bone(
            height: 55,
            width: double.infinity,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 15),
          Bone.text(words: 2, width: 70),
          const SizedBox(height: 16),
          Bone(
            height: 55,
            width: double.infinity,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 10),
          Bone.text(words: 1, width: 70),
          const SizedBox(height: 10),
          Bone(
            height: 55,
            width: double.infinity,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 20),
          Center(
            child: Bone(
              width: 200,
              height: 55,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 19),
          Center(child: Bone.text(words: 4, width: 180)),
          const SizedBox(height: 10),
          Bone(
            width: double.infinity,
            height: 50,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 10),
          Bone(
            width: double.infinity,
            height: 50,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '22'.tr,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'Start learning by creating your account',
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
      textAlign: TextAlign.left,
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
      textAlign: TextAlign.left,
    );
  }

  Widget _buildCreateAccountButton(SignUpControllerImp controller) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primary,
        ),
        child: MaterialButton(
          onPressed: controller.signup,
          child: Text('22'.tr, style: const TextStyle(color: AppColors.white)),
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
}
