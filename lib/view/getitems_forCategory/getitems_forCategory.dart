import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';
import 'package:ecommerce/core/constants/App_color/colore.dart';
import 'package:ecommerce/data/models/getitems_model/getitems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getitems_for_category/getitems_for_category_controller.dart';
import '../../core/constants/app_links/app_route.dart';

class GetitemsForCategory extends StatelessWidget {
  const GetitemsForCategory({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<GetitemsForCategoryController>()) {
      Get.put(GetitemsForCategoryController());
    }

    final controller = Get.find<GetitemsForCategoryController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(controller.categoryName),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GetBuilder<GetitemsForCategoryController>(
          builder: (controllerBuilder) => Handlingdataview(
            statusRequest: controllerBuilder.statusRequest,
            widget1: _buildLoadingGrid(),
            widget: controllerBuilder.items.isEmpty
                ? const _EmptyProductsState()
                : _buildProductsGrid(controllerBuilder),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: double.infinity,
                color: AppColors.backgroundGrey.withOpacity(0.2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 100,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 60,
            height: 12,
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey.withOpacity(0.25),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 50,
            height: 14,
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(GetitemsForCategoryController controller) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: controller.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        final item = controller.items[index];
        return _ProductCard(
          item: item,
          onFavoriteTap: () => controller.addFavorite(item.itemsId ?? ''),
        );
      },
    );
  }
}

class _EmptyProductsState extends StatelessWidget {
  const _EmptyProductsState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 70, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'No items found',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'There are no products in this category',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final itemsmodelall item;
  final VoidCallback onFavoriteTap;

  const _ProductCard({required this.item, required this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Get.toNamed(
                approute.productDetails,
                arguments: itemsmodelall.fromJson(item.toJson()),
              );
            },
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: 'product-${item.itemsId}',
                      child: Image.network(
                        '${Linkapi.rimages}/${item.itemsImage}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.backgroundGrey.withOpacity(0.2),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.grey,
                                size: 45,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return Container(
                            color: AppColors.backgroundGrey.withOpacity(0.2),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: onFavoriteTap,
                      icon: const Icon(
                        Icons.favorite_border,
                        color: AppColors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.itemsName ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'shose',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 3),
        Text(
          '\$${item.itemsPrice ?? 0}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
