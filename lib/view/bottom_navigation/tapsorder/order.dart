import 'package:ecommerce/controllers/bottomnavigation/BottomNavigation_controller.dart';

import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

import 'package:ecommerce/view/widget/orders/vieworder.dart';

import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:skeletonizer/skeletonizer.dart';

class OrderTabView extends StatelessWidget {
  const OrderTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GetBuilder<BottomNavigationControllerImp>(
        builder: (controller) {
          return Handlingdataview(
            statusRequest: controller.statusRequest,
            widget1: Skeletonizer(
              enabled: true,
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 14,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Bone(
                            width: 90,
                            height: 90,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Bone.text(width: 120),
                                const SizedBox(height: 8),
                                Bone.text(width: 80),
                                const SizedBox(height: 8),
                                Bone.text(width: 60),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            widget: GridView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 14,
                childAspectRatio: 2.5,
              ),
              itemCount: controller.ordersList.length,
              itemBuilder: (context, index) {
                final order = controller.ordersList[index];

                return OrderCard(
                  title: controller.formatLanguage(
                    order.itemsName!,
                    order.itemnameAR!,
                  ),
                  color: controller.formatLanguage(
                    order.namecolorEn!,
                    order.namecolorAr!,
                  ),
                  qty: order.orderCountitem!,
                  price: order.itemsPrice!.toString(),
                  image: "${Linkapi.rimages}/${order.itemsImage}",
                );
              },
            ),
          );
        },
      ),
    );
  }
}
