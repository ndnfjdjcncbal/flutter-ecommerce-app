import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/data/models/getitems_model/getitems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Search/Search_controller.dart';
import '../../core/constants/colore.dart';
import '../../linkapi.dart';
import '../approute.dart';
import 'search_loading_grid.dart';

class Allsearch extends StatelessWidget {
  const Allsearch({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerimp>(
      builder: (controller) => Expanded(
        child: Handlingdataview(
          statusRequest: controller.statusRequest,
          widget1: _buildLoadingGrid(),
          widget: controller.itemssearches.isEmpty
              ? _buildEmptyState()
              : _buildProductGrid(controller),
        ),
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return const SearchLoadingGrid();
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 70, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'No products found',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Try searching for another product',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(SearchControllerimp controller) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: controller.itemssearches.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) => _buildProductCard(controller, index),
    );
  }

  Widget _buildProductCard(SearchControllerimp controller, int index) {
    final currentItem = itemsmodelall.fromJson(controller.itemssearches[index]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Get.toNamed(approute.productDetails, arguments: currentItem);
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
                      tag: 'product-${currentItem.itemsId}',
                      child: Image.network(
                        '${Linkapi.rimages}/${currentItem.itemsImage}',
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
                          if (loadingProgress == null) return child;
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
                  const Positioned(
                    top: 12,
                    right: 12,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        if (currentItem.itemsId != null) {
                          controller.addfav(currentItem.itemsId!);
                        }
                      },
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
          currentItem.itemsName ?? '',
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
          '\$${currentItem.itemsPrice ?? 0}',
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
