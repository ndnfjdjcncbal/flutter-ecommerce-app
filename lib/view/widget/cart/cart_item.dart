import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/data/models/cartmodel.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  final cartmodel model;
  final bool isSelected;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final ValueChanged<bool?> onChanged;

  const CartItem({
    super.key,
    required this.model,
    required this.isSelected,
    required this.onAdd,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          fillColor: WidgetStatePropertyAll(
            isSelected ? AppColors.primary : AppColors.white,
          ),
          value: isSelected,
          onChanged: onChanged,
        ),
        const SizedBox(width: 5),

        SizedBox(
          height: 100,
          width: 83,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              "${Linkapi.rimages}/${model.itemsImage}",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),

        const SizedBox(width: 7),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.itemsName ?? ""),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Text("49".tr, style: TextStyle(color: AppColors.grey)),
                    const SizedBox(width: 7),
                    Text(
                      model.namecolorEn ?? "",
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _CircleButton(
                            icon: Icons.remove,
                            onPressed: onRemove,
                          ),

                          Text("${model.counitem}"),

                          _CircleButton(icon: Icons.add, onPressed: onAdd),
                        ],
                      ),
                    ),

                    Text(
                      "\$${model.itemsPrice}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CircleButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(80),
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        minWidth: 0,
        onPressed: onPressed,
        child: Icon(icon, size: 19),
      ),
    );
  }
}
