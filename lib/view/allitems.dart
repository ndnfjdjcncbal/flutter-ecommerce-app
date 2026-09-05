import 'package:ecommerce/controllers/Home/homecontroller.dart';
import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/data/models/getitems_model/getitems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../core/constants/colore.dart';
import '../../linkapi.dart';
import 'approute.dart';

class allitems extends StatelessWidget {
  const allitems({super.key});

  @override
  Widget build(BuildContext context) {
    final homacontrollerimp = Get.find<HomeControllerImpl>();

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
              Text("68".tr, textAlign: TextAlign.center),
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
              child: GetBuilder<HomeControllerImpl>(
                builder: (con) => Handlingdataview(
                  statusRequest: homacontrollerimp.statusRequest,
                  widget1: Skeletonizer(
                    enabled: true,
                    child: GridView.builder(
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Bone(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    Positioned(
                                      left: 115,
                                      top: 16,
                                      child: Bone.circle(size: 37),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Bone.text(words: 2),
                            const SizedBox(height: 3),
                            Bone.text(words: 1, width: 45),
                            const SizedBox(height: 3),
                            Bone.text(words: 1, width: 55),
                          ],
                        );
                      },
                    ),
                  ),
                  widget: GridView.builder(
                    itemCount: homacontrollerimp.items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (context, index) {
                      itemsmodelall currentItem = itemsmodelall.fromJson(
                        homacontrollerimp.items[index],
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
                                        child: Hero(
                                          tag: 'product-${currentItem.itemsId}',
                                          child: Image.network(
                                            "${Linkapi.rimages}/${currentItem.itemsImage}",
                                            height: 180,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 115,
                                      top: 16,
                                      child: Container(
                                        alignment: Alignment.center,
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
                                          homacontrollerimp.toggleFavorite(
                                            currentItem.itemsId!,
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
        ],
      ),
    );
  }
}
