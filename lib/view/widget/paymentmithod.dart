import 'package:ecommerce/core/constants/colore.dart';
import 'package:flutter/material.dart';

class PaymentMethodSheet extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final bool value;
  final VoidCallback onTap;

  const PaymentMethodSheet({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Image.asset(image, fit: BoxFit.contain),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subTitle,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: value ? AppColors.primary : AppColors.white,
                  border: Border.all(
                    color: value ? AppColors.primary : Colors.grey.shade400,
                  ),
                ),
                child: value
                    ? const Icon(Icons.check, color: AppColors.white, size: 14)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
