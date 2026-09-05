import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colore.dart';
import '../../approute.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 90,
            color: AppColors.grey.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Add items to get started",
            style: TextStyle(fontSize: 13, color: AppColors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primary),
            ),
            onPressed: () {
              Get.offAllNamed(approute.homepage0);
            },
            child: const Text(
              "Start Shopping",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
