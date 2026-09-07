import 'package:ecommerce/data/models/getitems_model/getitems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/Search/Search_controller.dart';
import '../../core/classes/handlingdataview.dart';
import '../../core/constants/colore.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';
import '../approute.dart';
import 'search_loading_grid.dart';

class mostpopular extends StatelessWidget {
  const mostpopular({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchControllerimp>();

    return GetBuilder<SearchControllerimp>(
      builder: (stateController) => Handlingdataview(
        statusRequest: stateController.statusRequest,
        widget1: _buildLoadingGrid(),
        widget: stateController.Mostpopular.isNotEmpty
            ? _buildProductGrid(stateController)
            : Center(child: Text('63'.tr)),
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return const SearchLoadingGrid();
  }

  Widget _buildProductGrid(SearchControllerimp controller) {
    return Expanded(
      child: GridView.builder(
        itemCount: controller.Mostpopular.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          childAspectRatio: 0.70,
        ),
        itemBuilder: (context, index) => _buildProductCard(controller, index),
      ),
    );
  }

  Widget _buildProductCard(SearchControllerimp controller, int index) {
    final currentItem = itemsmodelall.fromJson(controller.Mostpopular[index]);

    return InkWell(
      onTap: () {
        Get.toNamed(approute.productDetails, arguments: currentItem);
      },
      child: Column(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Hero(
                        tag: 'product-${currentItem.itemsId}',
                        child: Image.network(
                          '${Linkapi.rimages}/${currentItem.itemsImage}',
                          height: 180,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 115,
                    top: 16,
                    child: SizedBox(
                      width: 37,
                      height: 38,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 100,
                    child: MaterialButton(
                      onPressed: () {
                        controller.addfav(currentItem.itemsId!);
                      },
                      child: const Icon(
                        Icons.favorite_outline_outlined,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            currentItem.itemsName ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\$${currentItem.itemsPrice}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
