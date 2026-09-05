import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/data/models/addres/addres.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/Addres/addres_controller.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AddressControllerImp>()) {
      Get.put(AddressControllerImp());
    }

    final controller = Get.find<AddressControllerImp>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildPageTitle(),
            const SizedBox(height: 13),
            _buildPageDescription(),
            const SizedBox(height: 20),
            _AddressMapSelector(onTap: controller.goToMap),
            const SizedBox(height: 25),
            _buildSectionTitle('Select location'),
            const SizedBox(height: 15),
            Expanded(
              child: GetBuilder<AddressControllerImp>(
                builder: (controllerBuilder) => Handlingdataview(
                  statusRequest: controllerBuilder.statusRequest,
                  widget1: const _AddressSkeleton(),
                  widget: ListView.builder(
                    itemCount: controllerBuilder.addresview.length,
                    itemBuilder: (context, index) {
                      final address = controllerBuilder.addresview[index];
                      final isSelected =
                          controllerBuilder.selectedAddress == index;

                      return _AddressListItem(
                        address: address,
                        isSelected: isSelected,
                        imageUrl: controllerBuilder.getMapUrl(index),
                        onTap: () => controllerBuilder.onAddressSelected(index),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
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
        onPressed: () => Get.back(),
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

  Widget _buildPageTitle() {
    return const Text(
      'Choose your location',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildPageDescription() {
    return const Text(
      "Let's find your unforgettable event. Choose a\nlocation below to get started.",
      style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.6),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColors.black,
      ),
    );
  }
}

class _AddressMapSelector extends StatelessWidget {
  final VoidCallback onTap;

  const _AddressMapSelector({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black.withOpacity(0.1)),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_sharp, color: AppColors.primary),
          const SizedBox(width: 10),
          const Text(
            'San Diego, CA',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.my_location_rounded,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressListItem extends StatelessWidget {
  final addresmodel address;
  final bool isSelected;
  final String imageUrl;
  final VoidCallback onTap;

  const _AddressListItem({
    required this.address,
    required this.isSelected,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(21)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      address.addresCity ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${address.addresStreet}, ${address.addresCity}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.shade200,
                    width: 2.5,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressSkeleton extends StatelessWidget {
  const _AddressSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: const BorderRadius.all(Radius.circular(21)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Bone.text(width: 100),
                      const SizedBox(height: 8),
                      Bone.text(width: 180),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                const Bone.circle(size: 75),
              ],
            ),
          );
        },
      ),
    );
  }
}
