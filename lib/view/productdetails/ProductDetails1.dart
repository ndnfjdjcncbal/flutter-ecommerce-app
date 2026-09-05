import 'package:ecommerce/core/constants/colore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ProductDetails/ProductDetails1controller.dart';
import '../../linkapi.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProductDetailsControllerImp>()) {
      Get.put(ProductDetailsControllerImp());
    }

    final controller = Get.find<ProductDetailsControllerImp>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            top: 20,
            bottom: 150,
            child: Hero(
              tag: 'product-${controller.model.itemsId}',
              child: Image.network(
                '${Linkapi.rimages}/${controller.model.itemsImage}',
                fit: BoxFit.fitHeight,
                width: 5,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 380),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(top: 19),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(37),
                      topRight: Radius.circular(37),
                    ),
                  ),
                  child: GetBuilder<ProductDetailsControllerImp>(
                    builder: (controllerBuilder) => Column(
                      children: [
                        const SizedBox(height: 26),
                        _buildHeader(controllerBuilder),
                        const SizedBox(height: 5),
                        _buildLabel('58'.tr),
                        const SizedBox(height: 20),
                        _buildSectionTitle('49'.tr),
                        const SizedBox(height: 10),
                        _buildColorSelector(controllerBuilder),
                        const SizedBox(height: 20),
                        _buildSectionTitle('59'.tr),
                        const SizedBox(height: 8),
                        _buildDescription(controllerBuilder),
                        const SizedBox(height: 20),
                        _buildPriceRow(controllerBuilder),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(width: 40),
                Text('55'.tr, textAlign: TextAlign.center),
                const SizedBox(width: 50),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.favorite_border),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ProductDetailsControllerImp controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          controller.model.itemsName ?? '',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            controller.colorItems.isEmpty
                ? '0'
                : controller.countColor.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }

  Widget _buildColorSelector(ProductDetailsControllerImp controller) {
    if (controller.colorItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: List.generate(controller.colorItems.length, (index) {
        final colorItem = controller.colorItems[index];
        final colorId = int.tryParse(colorItem.itemscolorId ?? '');

        if (colorId == null) {
          return const SizedBox.shrink();
        }

        final isSelected = controller.selectedColor == colorId;
        final colorValue = controller.viewcolor(colorItem.namecolorEn);

        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => controller.selectColor(colorId),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorValue,
                border: isSelected
                    ? Border.all(color: Colors.white, width: 2)
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colorValue.withOpacity(0.5),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDescription(ProductDetailsControllerImp controller) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 12.5, color: Colors.grey[600], height: 1.5),
        children: [TextSpan(text: controller.model.itemsDesc)],
      ),
    );
  }

  Widget _buildPriceRow(ProductDetailsControllerImp controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${controller.model.itemsPrice}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: () {
            final itemId = controller.model.itemsId;
            if (itemId == null || itemId.isEmpty) {
              Get.snackbar('Cart', '56'.tr);
              return;
            }

            controller.increaseQuantity(
              itemId,
              controller.selectedColor.toString(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5B4FE9),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 18,
          ),
          label: Text(
            '57'.tr,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
