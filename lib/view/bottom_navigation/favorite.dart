import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/Cart/favoritecontroler.dart';

class Favorite extends StatelessWidget {
  Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FavoriteControllerImp>()) {
      Get.put(FavoriteControllerImp());
    }

    final controller = Get.find<FavoriteControllerImp>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _FavoriteHeader(),
            const SizedBox(height: 18),
            _FavoriteSearchField(controller: controller),
            const SizedBox(height: 18),
            GetBuilder<FavoriteControllerImp>(
              builder: (favoriteController) =>
                  _FavoriteTabBar(controller: favoriteController),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GetBuilder<FavoriteControllerImp>(
                builder: (favoriteController) => Handlingdataview(
                  statusRequest: favoriteController.statusRequest,
                  widget1: const _FavoriteSkeleton(),
                  widget:
                      favoriteController.pages[favoriteController.currentTab],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteSkeleton extends StatelessWidget {
  const _FavoriteSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFFE9EDF2),
        highlightColor: Color.fromARGB(255, 61, 68, 75),
        duration: Duration(milliseconds: 1400),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(width: 85, height: 12, color: Colors.grey),
            const SizedBox(height: 6),
            Container(width: 52, height: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _FavoriteHeader extends StatelessWidget {
  const _FavoriteHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 120),
        Text('48'.tr, style: const TextStyle(fontWeight: FontWeight.w500)),
        const Spacer(),
        Stack(
          children: [
            IconButton(
              onPressed: () => Get.toNamed(approute.notifications),
              icon: const Icon(Icons.notifications_none, size: 30),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FavoriteSearchField extends StatelessWidget {
  final FavoriteControllerImp controller;

  const _FavoriteSearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 11),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.grey),
        borderRadius: BorderRadius.circular(13),
      ),
      child: TextField(
        controller: controller.searchController,
        onChanged: (value) {
          if (value.isEmpty) {
            controller.isSearching = false;
            controller.loadFavoriteItems();
          }
        },
        onSubmitted: controller.handleSearchSubmit,
        decoration: InputDecoration(
          hintText: '62'.tr,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          prefixIcon: IconButton(
            padding: const EdgeInsets.only(bottom: 30),
            icon: const Icon(Icons.search, size: 47),
            onPressed: () {
              controller.handleSearchSubmit(controller.searchController.text);
            },
          ),
        ),
      ),
    );
  }
}

class _FavoriteTabBar extends StatelessWidget {
  final FavoriteControllerImp controller;

  const _FavoriteTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.tabs.length,
        itemBuilder: (context, index) {
          final isSelected = controller.currentTab == index;
          return GestureDetector(
            onTap: () => controller.changeTab(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(right: 9),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey, width: 0.5),
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                controller.tabs[index],
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
