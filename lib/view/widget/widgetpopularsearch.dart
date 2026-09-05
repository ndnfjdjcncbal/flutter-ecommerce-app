import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/data/models/Search/popularsearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/Search/Search_controller.dart';
import '../../linkapi.dart';

class popularsearch1 extends StatelessWidget {
  const popularsearch1({super.key});

  @override
  Widget build(BuildContext context) {
    SearchControllerimp homeController0 = Get.find<SearchControllerimp>();

    return GetBuilder<SearchControllerimp>(
      builder: (controller) {
        return Expanded(
          child: Handlingdataview(
            statusRequest: controller.statusRequest,

            widget1: Skeletonizer(
              enabled: true,
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.7,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Bone(
                            width: 107,
                            height: 107,
                            borderRadius: BorderRadius.circular(17),
                          ),

                          const SizedBox(width: 12),

                          const Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Bone.text(width: 100),
                                SizedBox(height: 8),
                                Bone.text(width: 140),
                              ],
                            ),
                          ),

                          const SizedBox(width: 30),

                          Bone(
                            width: 70,
                            height: 28,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            widget: GridView.builder(
              itemCount: homeController0.mostpopularnofilter.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.7,
              ),
              itemBuilder: (context, index) {
                popularsearch currentItem1 = popularsearch.fromJson(
                  homeController0.mostpopularnofilter[index],
                );

                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 107,
                          width: 107,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Image.network(
                              "${Linkapi.rimages}/${currentItem1.itemsImage!}",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(currentItem1.itemsName!),
                              Text(
                                "${homeController0.Formatsearchcount(currentItem1.totalsearch)} search today ",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 30),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: homeController0.getTagColor(
                              currentItem1.tag ?? "",
                            ),
                          ),
                          width: 70,
                          height: 28,
                          alignment: Alignment.center,
                          child: Text(
                            currentItem1.tag ?? "",
                            style: TextStyle(
                              color: homeController0.getTagTextColor(
                                currentItem1.tag,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
