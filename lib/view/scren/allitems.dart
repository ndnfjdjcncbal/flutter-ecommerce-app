import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/counstant/colore.dart';
import '../../../linkapi.dart';
import '../../controller/home/homecontroller.dart';
import '../../data/model/getitems_model/getitems.dart';
import '../approute.dart';

class allitems extends StatelessWidget {
  const allitems({super.key});

  @override
  Widget build(BuildContext context) {
    homacontrollerimp homeController0 = Get.find<homacontrollerimp>();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              SizedBox(width: 100),
              Text("All Arrifals", textAlign: TextAlign.center),
              SizedBox(width: 70),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.favorite_border),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: GetBuilder<homacontrollerimp>(
                builder: (con) => Expanded(
                  child: Handlingdataview(
                    statusRequest: homeController0.statusRequest,
                    widget: GridView.builder(
                      itemCount: homeController0.itemsl.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.70,
                      ),
                      itemBuilder: (context, index) {
                        itemsmodelall currentItem = itemsmodelall.fromJson(
                          homeController0.itemsl[index],
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
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
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
                                            homeController0.addfav(
                                              currentItem.itemId!,
                                            );
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
