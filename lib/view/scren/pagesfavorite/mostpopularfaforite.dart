import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/classes/handlingdataview.dart';
import '../../../../data/model/favorite/popularmodelfaforite.dart';
import '../../../../linkapi.dart';
import '../../../controller/Cart/favoritecontroler.dart';
import '../../approute.dart';

class MostPopularFavorite extends StatelessWidget {
  MostPopularFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteControllerImp controllerImp = Get.put(FavoriteControllerImp());

    return Center(
      child: Handlingdataview(
        statusRequest: controllerImp.statusRequest,
        widget: GetBuilder<FavoriteControllerImp>(
          builder: (con) => GridView.builder(
            itemCount: con.Mostpopular.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) {
              modelpopularfavorite currentItem = modelpopularfavorite.fromJson(
                con.Mostpopular[index],
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
                                  "/${controllerImp.itemssearches[index]['items_image']}",
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
