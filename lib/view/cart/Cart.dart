import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/view/widget/cart/emptycard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/Cart/Cart_controlle.dart';
import '../widget/cart/cart_item.dart';
import '../widget/cart/promocode.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Cartcontrollerump());

    return Scaffold(
      body: GetBuilder<Cartcontrollerump>(
        builder: (controllerBuild) => Handlingdataview(
          statusRequest: controllerBuild.statusRequest,
          onRetry: controllerBuild.viewcart,
          widget1: _buildCartSkeleton(),
          widget: controllerBuild.cartlist.isEmpty
              ? const EmptyCartWidget()
              : _buildCartContent(controllerBuild),
        ),
      ),
    );
  }

  Widget _buildCartContent(Cartcontrollerump controllerBuild) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3.2,
              ),
              itemCount: controllerBuild.cartlist.length,
              itemBuilder: (context, index) {
                final item = controllerBuild.cartlist[index];

                return CartItem(
                  model: item,
                  isSelected: controllerBuild.selectedItems[index],
                  onChanged: (value) {
                    controllerBuild.toggleItem(index, value!);
                  },
                  onAdd: () {
                    controllerBuild.increaseQuantity(
                      item.itemsId!,
                      item.cartColor!,
                    );
                  },
                  onRemove: () {},
                );
              },
            ),
          ),
          CartSummarySection(
            promoController: controllerBuild.cupon,
            subtotal:
                controllerBuild.cartlist.isNotEmpty &&
                    controllerBuild.index1 < controllerBuild.cartlist.length &&
                    controllerBuild.selectedItems[controllerBuild.index1] ==
                        true
                ? controllerBuild.getSelectedSubtotal()
                : 0,
            shipping: controllerBuild.shipping,
            total:
                controllerBuild.cartlist.isNotEmpty &&
                    controllerBuild.index1 < controllerBuild.cartlist.length &&
                    controllerBuild.selectedItems[controllerBuild.index1] ==
                        true
                ? controllerBuild.getSelectedSubtotalwithshiping()
                : 0,
            onApplyPromo: () {
              controllerBuild.cupondiscount(controllerBuild.id);
            },
            onCheckout: () {
              controllerBuild.getSelectedCartItems();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        const SizedBox(width: 100),
        Text('48'.tr, textAlign: TextAlign.center),
        const SizedBox(width: 70),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.favorite_border),
        ),
      ],
    );
  }

  Widget _buildCartSkeleton() {
    return Container(
      color: AppColors.backgroundGrey,
      padding: const EdgeInsets.all(16),
      child: Skeletonizer(
        enabled: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildSkeletonHeader(),
              const SizedBox(height: 24),
              _buildSkeletonHeroCard(),
              const SizedBox(height: 20),
              ...List.generate(3, (index) => _buildSkeletonProductCard()),
              const SizedBox(height: 16),
              _buildSkeletonSummaryCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonHeader() {
    return Row(
      children: [
        Bone(width: 36, height: 36, borderRadius: BorderRadius.circular(12)),
        const Spacer(),
        Bone(width: 120, height: 22, borderRadius: BorderRadius.circular(8)),
        const Spacer(),
        Bone(width: 36, height: 36, borderRadius: BorderRadius.circular(12)),
      ],
    );
  }

  Widget _buildSkeletonHeroCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Bone(width: 68, height: 68, borderRadius: BorderRadius.circular(18)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone.text(words: 3),
                const SizedBox(height: 8),
                Bone.text(words: 2),
                const SizedBox(height: 10),
                Bone.text(words: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonProductCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Bone(width: 96, height: 96, borderRadius: BorderRadius.circular(20)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone.text(words: 4),
                const SizedBox(height: 10),
                Bone.text(words: 2),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Bone(
                      width: 70,
                      height: 24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    const SizedBox(width: 10),
                    Bone(
                      width: 90,
                      height: 24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Bone(width: 150, height: 14, borderRadius: BorderRadius.circular(8)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Bone(height: 14, borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(width: 16),
              Bone(
                width: 80,
                height: 14,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Bone(height: 14, borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(width: 16),
              Bone(height: 14, borderRadius: BorderRadius.circular(8)),
            ],
          ),
          const SizedBox(height: 18),
          Bone(
            height: 52,
            width: double.infinity,
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
    );
  }
}
