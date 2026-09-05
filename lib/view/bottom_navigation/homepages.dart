import 'package:ecommerce/controllers/Home/homecontroller.dart';
import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/view/bottom_navigation/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/UserGreetingBar.dart';
import 'favorite.dart';
import 'myorder.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllerImpl());

    return Scaffold(
      bottomNavigationBar: GetBuilder<HomeControllerImpl>(
        builder: (controller) => BottomNavigationBar(
          currentIndex: controller.currentBottomNavIndex,
          onTap: (index) {
            controller.updateNavigationIndex(index);
          },
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
          selectedLabelStyle: TextStyle(color: AppColors.primary),
          unselectedLabelStyle: TextStyle(color: AppColors.grey),

          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 30),

              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined, size: 30),
              label: "Order",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline, size: 30),
              label: "Favorite",
            ),
          ],
        ),
      ),
      appBar: AppBar(toolbarHeight: 2),

      body: GetBuilder<HomeControllerImpl>(
        builder: (controller) => IndexedStack(
          index: controller.currentBottomNavIndex,
          children: [
            Column(
              children: [
                Usergreetingbar(),
                SizedBox(height: 40),
                Expanded(
                  child: GetBuilder<HomeControllerImpl>(
                    builder: (controller) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.updateTabIndex(0);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                      color: controller.currentTabIndex == 0
                                          ? AppColors.black
                                          : AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: controller.currentTabIndex == 0
                                        ? 90
                                        : 0,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: controller.currentTabIndex == 0
                                          ? AppColors.primary
                                          : AppColors.grey,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),

                            GestureDetector(
                              onTap: () {
                                controller.updateTabIndex(1);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                      color: controller.currentTabIndex == 1
                                          ? AppColors.black
                                          : AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: controller.currentTabIndex == 1
                                        ? 90
                                        : 0,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: controller.currentTabIndex == 1
                                          ? AppColors.primary
                                          : AppColors.grey,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: controller.currentBottomNavIndex == 0
                              ? controller.pages[controller.currentTabIndex]
                              : controller.bottomNavigationPages[controller
                                        .currentBottomNavIndex -
                                    1],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Myorder(),
            myprofile(),
            Favorite(),
          ],
        ),
      ),
    );
  }
}
