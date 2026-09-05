import 'dart:io';

import 'package:ecommerce/controllers/profile/profile_controller.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class myprofile extends StatelessWidget {
  const myprofile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ProfileControllerImpl>()
        ? Get.find<ProfileControllerImpl>()
        : Get.lazyPut<ProfileControllerImpl>(() => ProfileControllerImpl());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
        ),
        title: Text(
          '75'.tr,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<ProfileControllerImpl>(
          builder: (controller) => SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                GestureDetector(
                  onTap: controller.updatePhoto,
                  child: Obx(
                    () => Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: const Color(0xFFE8F0FF),
                          backgroundImage:
                              controller.profileImageUrl.value.isNotEmpty
                              ? (controller.profileImageUrl.value.startsWith(
                                      'http',
                                    )
                                    ? NetworkImage(
                                        controller.profileImageUrl.value,
                                      )
                                    : FileImage(
                                        File(controller.profileImageUrl.value),
                                      ))
                              : null,
                          child: controller.profileImageUrl.value.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 42,
                                  color: AppColors.primary,
                                )
                              : null,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1F1E5EFF),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                _ProfileTextFieldWithValidation(
                  label: '78'.tr,
                  controller: controller.fullNameController,
                  errorText: controller.fullNameError,
                  onChanged: (value) => controller.validateFullName(value),
                  prefixIcon: Icons.person_outline,
                  hint: '127'.tr,
                ),
                const SizedBox(height: 18),

                _ProfileTextFieldWithValidation(
                  label: '80'.tr,
                  controller: controller.emailController,
                  errorText: controller.emailError,
                  onChanged: (value) => controller.validateEmail(value),
                  prefixIcon: Icons.email_outlined,
                  hint: '129'.tr,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 18),

                _ProfileTextFieldWithValidation(
                  label: '82'.tr,
                  controller: controller.phoneController,
                  errorText: controller.phoneError,
                  onChanged: (value) => controller.validatePhone(value),
                  prefixIcon: Icons.phone_outlined,
                  hint: '130'.tr,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        controller.statusRequestSave == StatusRequest.loading
                        ? null
                        : () => controller.saveProfile(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: controller.statusRequestSave == StatusRequest.loading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white,
                              ),
                            ),
                          )
                        : Text(
                            '84'.tr,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileTextFieldWithValidation extends StatelessWidget {
  const _ProfileTextFieldWithValidation({
    required this.label,
    required this.controller,
    required this.errorText,
    required this.onChanged,
    required this.prefixIcon,
    required this.hint,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final TextEditingController controller;
  final RxString errorText;
  final Function(String) onChanged;
  final IconData prefixIcon;
  final String hint;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        Obx(
          () => TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.grey),
              prefixIcon: Icon(prefixIcon, color: AppColors.primary),
              errorText: errorText.value.isEmpty ? null : errorText.value,
              errorStyle: const TextStyle(
                color: AppColors.hotBadge,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              // Border Styling
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: errorText.value.isEmpty
                      ? AppColors.grey
                      : AppColors.hotBadge,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: errorText.value.isEmpty
                      ? AppColors.primary
                      : AppColors.hotBadge,
                  width: 2,
                ),
              ),
              // Dynamic background color
              filled: true,
              fillColor: errorText.value.isEmpty
                  ? AppColors.white
                  : AppColors.hotBadge.withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
