import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/auth/verifiedcodeloginn.dart';
import '../widget/materialbutton.dart';

class Verfiedcodelogin extends StatelessWidget {
  const Verfiedcodelogin({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<VerifiedCodeLoginControllerImp>()) {
      Get.put(VerifiedCodeLoginControllerImp());
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 70.3,
        shape: Border(bottom: BorderSide(color: AppColors.black, width: 1)),
        backgroundColor: AppColors.white,
        title: Text('47'.tr),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: GetBuilder<VerifiedCodeLoginControllerImp>(
              builder: (controller) => Handlingdataview(
                statusRequest: controller.statusRequest,
                widget1: _buildLoadingState(),
                widget: _buildContent(controller),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Skeletonizer(
      enabled: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 9),
          Center(
            child: Bone(
              width: 180,
              height: 180,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 19),
          Center(child: Bone.text(width: 130)),
          const SizedBox(height: 10),
          Center(child: Bone.text(width: 250)),
          const SizedBox(height: 9),
          Center(child: Bone.text(width: 170)),
          const SizedBox(height: 16),
          Bone(
            width: double.infinity,
            height: 55,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 50),
          Bone(width: 180, height: 50, borderRadius: BorderRadius.circular(30)),
          const SizedBox(height: 10),
          Center(child: Bone.text(width: 180)),
        ],
      ),
    );
  }

  Widget _buildContent(VerifiedCodeLoginControllerImp controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 9),
        Center(child: ClipRRect(child: Image.asset('assets/verfi.png'))),
        const SizedBox(height: 19),
        Text(
          '42'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          '43'.tr,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 9),
        const Text(
          'ik8043873@gmail.com',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Pinput(
          length: 5,
          defaultPinTheme: controller.defaultPinTheme,
          focusedPinTheme: controller.focusedPinTheme,
          onCompleted: (pin) async {
            await controller.checkCodeLogin(pin);
          },
        ),
        const SizedBox(height: 50),
        Materialbutton(text: '44'.tr, onPressed: () {}),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Row(
            children: [
              Text('46'.tr, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
