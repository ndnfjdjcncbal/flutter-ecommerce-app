import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/Addres/Add_Addres_controller.dart';

class AddressPage2 extends StatelessWidget {
  const AddressPage2({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AddaddresControllerImp>()) {
      Get.put(AddaddresControllerImp());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<AddaddresControllerImp>(
          builder: (controllerBuilder) => Handlingdataview(
            statusRequest: controllerBuilder.statusRequest,
            widget1: const _AddAddressSkeleton(),
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Text(
                  'Add Your Address',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                _AddressTextField(
                  controller: controllerBuilder.country,
                  label: '65'.tr,
                  icon: Icons.public,
                ),
                const SizedBox(height: 20),
                _AddressTextField(
                  controller: controllerBuilder.city,
                  label: '66'.tr,
                  icon: Icons.location_city,
                ),
                const SizedBox(height: 20),
                _AddressTextField(
                  controller: controllerBuilder.street,
                  label: '67'.tr,
                  icon: Icons.signpost,
                ),
                const SizedBox(height: 30),
                _SaveAddressButton(onPressed: controllerBuilder.AddAddres),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.black,
      leading: IconButton(
        onPressed: () => Get.toNamed(approute.Mappage),
        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
      ),
      title: const Text(
        'Address',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  const _AddressTextField({
    required this.controller,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _SaveAddressButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveAddressButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save Address',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
}

class _AddAddressSkeleton extends StatelessWidget {
  const _AddAddressSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Bone.text(width: 180),
          const SizedBox(height: 30),
          Bone(
            width: double.infinity,
            height: 58,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(height: 20),
          Bone(
            width: double.infinity,
            height: 58,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(height: 20),
          Bone(
            width: double.infinity,
            height: 58,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(height: 30),
          Bone(
            width: double.infinity,
            height: 55,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
