import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controller/Search/Search_controller.dart';
import '../../../core/classes/handlingdataview.dart';
import '../../../core/counstant/colore.dart';
import '../../../data/model/getitems_model/getitems.dart';
import '../../../linkapi.dart';
import '../../approute.dart';

class cheapest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchControllerimp homeController0 = Get.find<SearchControllerimp>();

    return GetBuilder<SearchControllerimp>(
      builder: (con) => Handlingdataview(
        statusRequest: con.statusRequest,
        widget: Expanded(
          child: GridView.builder(
            itemCount: homeController0.cheapestdata.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) {
              itemsmodelall currentItem = itemsmodelall.fromJson(
                homeController0.cheapestdata[index],
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
                    "\$${currentItem.itemsPrice}",
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
