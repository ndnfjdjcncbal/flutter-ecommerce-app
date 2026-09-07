import 'package:ecommerce/controllers/profile/profile_controller.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/constants/App_color/colore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileControllerImpl());

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
          '86'.tr,
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
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                _PasswordField(
                  label: '88'.tr,
                  controller: controller.currentPasswordController,
                  errorText: controller.currentPasswordError,
                  onChanged: (value) =>
                      controller.validateCurrentPassword(value),
                  suffixIcon: Icons.visibility_off_outlined,
                ),
                const SizedBox(height: 18),
                _PasswordField(
                  label: '90'.tr,
                  controller: controller.newPasswordController,
                  errorText: controller.newPasswordError,
                  onChanged: (value) => controller.validateNewPassword(value),
                  suffixIcon: Icons.visibility_off_outlined,
                ),
                const SizedBox(height: 18),
                _PasswordField(
                  label: '92'.tr,
                  controller: controller.confirmPasswordController,
                  errorText: controller.confirmPasswordError,
                  onChanged: (value) =>
                      controller.validateConfirmPassword(value),
                  suffixIcon: Icons.visibility_off_outlined,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        controller.statusRequestPassword ==
                            StatusRequest.loading
                        ? null
                        : () => controller.changePassword(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child:
                        controller.statusRequestPassword ==
                            StatusRequest.loading
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
                            '94'.tr,
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

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.errorText,
    required this.onChanged,
    required this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final RxString errorText;
  final ValueChanged<String> onChanged;
  final IconData suffixIcon;

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
            obscureText: true,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: label,
              hintStyle: const TextStyle(color: AppColors.grey),
              filled: true,
              fillColor: errorText.value.isEmpty
                  ? AppColors.white
                  : AppColors.hotBadge.withOpacity(0.05),
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
              errorText: errorText.value.isEmpty ? null : errorText.value,
              errorStyle: const TextStyle(
                color: AppColors.hotBadge,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              suffixIcon: Icon(suffixIcon, color: AppColors.grey),
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
