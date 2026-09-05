import 'package:ecommerce/controllers/bottomnavigation/BottomNavigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../approute.dart';

class Myorder extends StatelessWidget {
  Myorder({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<BottomNavigationControllerImp>()) {
      Get.put(BottomNavigationControllerImp());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<BottomNavigationControllerImp>(
          builder: (controller) {
            return Column(
              children: [
                const _OrderHeader(),
                const SizedBox(height: 8),
                _OrderTabs(controller: controller),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: const Color(0xffF1F1F4),
                ),
                const SizedBox(height: 16),
                Expanded(child: controller.tabs[controller.currentIndex]),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.offAllNamed(approute.homepage0),
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            tooltip: 'Back to Home',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const Spacer(),
          const Text(
            'My Order',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff292929),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.shopping_bag_outlined,
            size: 20,
            color: Color(0xff292929),
          ),
        ],
      ),
    );
  }
}

class _OrderTabs extends StatelessWidget {
  final BottomNavigationControllerImp controller;

  const _OrderTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    final tabs = ['My Order', 'History'];

    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = controller.currentIndex == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => controller.changePage(index),
            child: Column(
              children: [
                Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? const Color(0xffA78BFA)
                        : const Color(0xffC8C8D0),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 1.5,
                  width: isSelected ? 70 : 0,
                  decoration: BoxDecoration(
                    color: const Color(0xff6C5CE7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
