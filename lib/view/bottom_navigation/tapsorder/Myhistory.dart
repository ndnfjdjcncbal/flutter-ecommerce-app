import 'package:ecommerce/controllers/bottomnavigation/BottomNavigation_controller.dart';
import 'package:ecommerce/core/classes/handlingdataview.dart';

import 'package:ecommerce/linkapi.dart';

import 'package:ecommerce/view/widget/orders/historycard.dart';

import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:skeletonizer/skeletonizer.dart';

class OrderHistoryTab extends StatelessWidget {
  const OrderHistoryTab({super.key});

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
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Card(
                      child: SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 15,
                                    width: 120,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 12,
                                    width: 80,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 14,
                                    width: 60,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
              itemCount: controller.ordersList?.length,
              itemBuilder: (context, index) {
                final order = controller.ordersList[index];

                return HistoryCard(
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
