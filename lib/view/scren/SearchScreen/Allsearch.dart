import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Search/Search_controller.dart';
import '../../../core/counstant/colore.dart';
import '../../../data/model/getitems_model/getitems.dart';
import '../../../linkapi.dart';
import '../../approute.dart';

class Allsearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SearchControllerimp homeController0 = Get.find<SearchControllerimp>();

    return GetBuilder<SearchControllerimp>(
      builder: (con) => Expanded(
        child: Handlingdataview(
          statusRequest: con.statusRequest,
          widget: GridView.builder(
            itemCount: con.itemssearches.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) {
              itemsmodelall currentItem = itemsmodelall.fromJson(
                con.itemssearches[index],
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
                                  "/${currentItem.itemsImage}",
                                  height: 180,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 115,
                              top: 16,
                              child: Container(
                                alignment: AlignmentGeometry.center,
                                width: 37,
                                height: 38,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(80),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              left: 100,
                              child: MaterialButton(
                                onPressed: () {
                                  homeController0.addfav(currentItem.itemsId!);
                                },
                                child: Icon(
                                  Icons.favorite_outline_outlined,
                                  color: AppColors.white,
                                ),
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
