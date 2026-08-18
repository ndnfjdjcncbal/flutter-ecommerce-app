import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/classes/handlingdataview.dart';
import '../../../../data/model/favorite/latestfavorite.dart';
import '../../../../linkapi.dart';
import '../../../controller/Cart/favoritecontroler.dart';
import '../../approute.dart';

class LatestFavorite extends StatelessWidget {
  LatestFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteControllerImp controllerImp = Get.put(FavoriteControllerImp());

    return Center(
      child: GetBuilder<FavoriteControllerImp>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: GridView.builder(
            itemCount: controller.latest.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) {
              modellatefavorite currentItem = modellatefavorite.fromJson(
                controller.latest[index],
              );
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(80),
                                  ),
                                ),
                                child: Image.network(
                                  "${Linkapi.rimages}"
                                  "/${controller.itemssearches[index]['items_image']}",
                                  height: 180,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),

                            Positioned(
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
                    currentItem.itemsName!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("shose", style: TextStyle(color: Colors.grey)),
                  Text(
                    "\$${currentItem.itemsPrice!}",
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
      ),
    );
  }
}
