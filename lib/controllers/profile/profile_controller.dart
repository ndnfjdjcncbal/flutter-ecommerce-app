import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/constants/colore.dart';

abstract class ProfileController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void saveProfile();
  void changePassword();
  void updatePhoto();
  void getProfileData();
}

class ProfileControllerImpl extends ProfileController {
  late Profile profileDataSource;
  Myservice myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestSave = StatusRequest.none;
  StatusRequest statusRequestPassword = StatusRequest.none;

  Map<String, dynamic> profileData = {};
  final ImagePicker _imagePicker = ImagePicker();

  RxString profileImageUrl = ''.obs;

  RxString fullNameError = ''.obs;
  RxString emailError = ''.obs;
  RxString phoneError = ''.obs;
  RxString currentPasswordError = ''.obs;
  RxString newPasswordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  void _showErrorDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        color: AppColors.hotBadge,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      middleText: message,
      middleTextStyle: const TextStyle(
        color: AppColors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppColors.white,
      radius: 16,
      confirmTextColor: AppColors.white,
      buttonColor: AppColors.hotBadge,
      textConfirm: '165'.tr,
      onConfirm: () => Get.back(),
    );
  }

  void _showSuccessDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      middleText: message,
      middleTextStyle: const TextStyle(
        color: AppColors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppColors.white,
      radius: 16,
      confirmTextColor: AppColors.white,
      buttonColor: AppColors.primary,
      textConfirm: '165'.tr,
      onConfirm: () => Get.back(),
    );
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: AppColors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void validateFullName(String value) {
    fullNameError.value = '';
    if (value.isEmpty) {
      fullNameError.value = '102'.tr;
    } else if (value.length < 3) {
      fullNameError.value = '104'.tr;
    } else if (!RegExp(r'^[a-zA-Z\s\u0600-\u06FF]+$').hasMatch(value)) {
      fullNameError.value = '106'.tr;
    }
  }

  void validateEmail(String value) {
    emailError.value = '';
    if (value.isEmpty) {
      emailError.value = '108'.tr;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      emailError.value = '110'.tr;
    }
  }

  void validatePhone(String value) {
    phoneError.value = '';
    if (value.isEmpty) {
      phoneError.value = '112'.tr;
    } else if (!RegExp(r'^[0-9]{10,}$').hasMatch(value.replaceAll(' ', ''))) {
      phoneError.value = '114'.tr;
    }
  }

  void validateCurrentPassword(String value) {
    currentPasswordError.value = '';
    if (value.isEmpty) {
      currentPasswordError.value = '116'.tr;
    }
  }

  void validateNewPassword(String value) {
    newPasswordError.value = '';
    if (value.isEmpty) {
      newPasswordError.value = '118'.tr;
    } else if (value.length < 6) {
      newPasswordError.value = '120'.tr;
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      newPasswordError.value = '122'.tr;
    }
  }

  void validateConfirmPassword(String value) {
    confirmPasswordError.value = '';
    if (value.isEmpty) {
      confirmPasswordError.value = '124'.tr;
    } else if (value != newPasswordController.text) {
      confirmPasswordError.value = '126'.tr;
    }
  }

  @override
  void onInit() {
    profileDataSource = Profile(crud());

    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    getProfileData();
    super.onInit();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void getProfileData() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      String userId = myServices.sharedPreferences.getString("id") ?? "";
      if (userId.isEmpty) {
        statusRequest = StatusRequest.failure;
        update();
        _showErrorDialog('133'.tr, '135'.tr);
        return;
      }

      var response = await profileDataSource.getProfile(userId: userId);

      if (response == StatusRequest.offlinefailure) {
        statusRequest = StatusRequest.offlinefailure;
        update();
        return;
      }

      print("Profile Response: $response");

      if (response != null && response['status'] == "success") {
        profileData = response['data'] ?? {};

        fullNameController.text = profileData['user_name'] ?? '';
        emailController.text = profileData['user_email'] ?? '';
        phoneController.text = profileData['user_phone'] ?? '';

        final imageValue = profileData['user_image'] ?? '';
        profileImageUrl.value = imageValue is String ? imageValue : '';

        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
        _showErrorDialog('133'.tr, response?['message'] ?? '137'.tr);
      }

      update();
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print("getProfileData error: $e");
      _showErrorDialog('133'.tr, '${'139'.tr}: $e');
    }
  }

  @override
  void saveProfile() async {
    try {
      fullNameError.value = '';
      emailError.value = '';
      phoneError.value = '';

      validateFullName(fullNameController.text);
      validateEmail(emailController.text);
      validatePhone(phoneController.text);

      if (fullNameError.value.isNotEmpty ||
          emailError.value.isNotEmpty ||
          phoneError.value.isNotEmpty) {
        return;
      }

      statusRequestSave = StatusRequest.loading;
      update();

      String userId = myServices.sharedPreferences.getString("id") ?? "";

      var response = await profileDataSource.updateProfile(
        userId: userId,
        userName: fullNameController.text,
        userEmail: emailController.text,
      );

      if (response == StatusRequest.offlinefailure) {
        statusRequestSave = StatusRequest.offlinefailure;
        update();
        _showErrorDialog('149'.tr, '151'.tr);
        return;
      }

      print("Update Profile Response: $response");

      if (response != null && response['status'] == "success") {
        statusRequestSave = StatusRequest.success;
        _showSuccessDialog('32'.tr, '141'.tr);

        getProfileData();
      } else {
        statusRequestSave = StatusRequest.failure;
        _showErrorDialog('143'.tr, response?['message'] ?? '143'.tr);
      }

      update();
    } catch (e) {
      statusRequestSave = StatusRequest.failure;
      update();
      print("saveProfile error: $e");
      _showErrorDialog('133'.tr, '${'139'.tr}: $e');
    }
  }

  @override
  void changePassword() async {
    try {
      currentPasswordError.value = '';
      newPasswordError.value = '';
      confirmPasswordError.value = '';

      validateCurrentPassword(currentPasswordController.text);
      validateNewPassword(newPasswordController.text);
      validateConfirmPassword(confirmPasswordController.text);

      if (currentPasswordError.value.isNotEmpty ||
          newPasswordError.value.isNotEmpty ||
          confirmPasswordError.value.isNotEmpty) {
        return;
      }

      statusRequestPassword = StatusRequest.loading;
      update();

      String userId = myServices.sharedPreferences.getString("id") ?? "";

      var response = await profileDataSource.changePassword(
        userId: userId,
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (response == StatusRequest.offlinefailure) {
        statusRequestPassword = StatusRequest.offlinefailure;
        update();
        _showErrorDialog('149'.tr, '151'.tr);
        return;
      }

      print("Change Password Response: $response");

      if (response != null && response['status'] == "success") {
        statusRequestPassword = StatusRequest.success;
        _showSuccessDialog('32'.tr, '145'.tr);

        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        currentPasswordError.value = '';
        newPasswordError.value = '';
        confirmPasswordError.value = '';

        Future.delayed(const Duration(seconds: 2), () => Get.back());
      } else {
        statusRequestPassword = StatusRequest.failure;
        _showErrorDialog('147'.tr, response?['message'] ?? '147'.tr);
      }

      update();
    } catch (e) {
      statusRequestPassword = StatusRequest.failure;
      update();
      print("changePassword error: $e");
      _showErrorDialog('133'.tr, '${'139'.tr}: $e');
    }
  }

  Future<void> _pickProfileImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (pickedFile == null) {
        Get.back();
        return;
      }

      Get.back();
      final String imagePath = pickedFile.path;
      profileImageUrl.value = imagePath;

      final userId = myServices.sharedPreferences.getString("id") ?? '';
      if (userId.isEmpty) {
        _showErrorDialog('133'.tr, '135'.tr);
        return;
      }

      statusRequestSave = StatusRequest.loading;
      update();

      final response = await profileDataSource.updateProfileImage(
        userId: userId,
        imagePath: imagePath,
      );

      if (response == StatusRequest.offlinefailure) {
        statusRequestSave = StatusRequest.offlinefailure;
        update();
        _showErrorDialog('لا توجد اتصالات', 'يرجى التحقق من اتصال الإنترنت');
        return;
      }

      if (response != null && response['status'] == 'success') {
        statusRequestSave = StatusRequest.success;
        final serverImage =
            response['data']?['user_image'] ??
            response['data']?['image'] ??
            response['image'] ??
            imagePath;
        profileImageUrl.value = serverImage ?? imagePath;
        _showSuccessDialog('32'.tr, '153'.tr);
      } else {
        statusRequestSave = StatusRequest.failure;
        _showErrorDialog('143'.tr, response?['message'] ?? '155'.tr);
      }

      update();
    } catch (e) {
      statusRequestSave = StatusRequest.failure;
      update();
      print('updatePhoto error: $e');
      _showErrorDialog('133'.tr, '${'157'.tr}: $e');
    }
  }

  @override
  void updatePhoto() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Text(
                '159'.tr,
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 18),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text('161'.tr),
                onTap: () => _pickProfileImage(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text('163'.tr),
                onTap: () => _pickProfileImage(ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
