import 'package:ecommerce/core/constants/app_links/linkapi.dart';
import 'package:ecommerce/data/models/favorite/Cheapestmodelfavorite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/classes/handlingdataview.dart';
import '../../controllers/Cart/favoritecontroler.dart';
import '../../core/constants/app_links/app_route.dart';

class CheapestFavorite extends StatelessWidget {
  const CheapestFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FavoriteControllerImp>()) {
      Get.put(FavoriteControllerImp());
    }

    final controller = Get.find<FavoriteControllerImp>();

    return Center(
      child: GetBuilder<FavoriteControllerImp>(
        builder: (favoriteController) {
          final items = favoriteController.cheapestItems;

          return Handlingdataview(
            statusRequest: favoriteController.statusRequest,
            widget: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (context, index) {
                final currentItem = modelcheapestrfavorite.fromJson(
                  items[index],
                );
                final imageUrl =
                    '${Linkapi.rimages}/${items[index]['items_image']}';

                return Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            approute.productDetails,
                            arguments: currentItem,
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(80),
                                    ),
                                  ),
                                  child: Hero(
                                    tag: 'product-${currentItem.itemsId}',
                                    child: Image.network(
                                      imageUrl,
                                      height: 180,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: 12,
                                left: 130,
                                child: Icon(
                                  Icons.favorite_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
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
                      '\$${currentItem.itemsPrice ?? 0}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
            widget1: Skeletonizer(
              enabled: true,
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Product Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('shose', style: TextStyle(color: Colors.grey)),
                      const Text(
                        '\$000',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
