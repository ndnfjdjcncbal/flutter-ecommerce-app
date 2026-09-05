import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colore.dart';
import '../../approute.dart';

class SuccessCheckoutBottomSheet extends StatelessWidget {
  const SuccessCheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 26),
          Container(
            width: 200,
            height: 200,

            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Image.asset(
                'assets/OrderSuccessfully.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Order Successfully',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your order will be packed by the clerk, will\narrive at your house in 3 to 4 days',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.grey, height: 1.5),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Get.toNamed(approute.order);
              },
              child: const Text(
                'Order Tracking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Get.offAllNamed(approute.homepage0);
              },
              child: const Text(
                'Go to Home',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
