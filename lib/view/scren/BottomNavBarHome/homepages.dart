import 'package:ecommerce/core/counstant/colore.dart';
import 'package:ecommerce/view/scren/BottomNavBarHome/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home/homecontroller.dart';
import '../../widget/UserGreetingBar.dart';
import 'favorite.dart';
import 'myorder.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    homacontrollerimp controller = Get.put(homacontrollerimp());

    return Scaffold(
      bottomNavigationBar: GetBuilder<homacontrollerimp>(
        builder: (controller) => BottomNavigationBar(
          currentIndex: controller.currentTabicon,
          onTap: (index) {
            controller.iconchnage(index);
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
              icon: Icon(Icons.favorite_outline, size: 30),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined, size: 30),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: "Profile",
            ),
          ],
        ),
      ),
      appBar: AppBar(toolbarHeight: 2),

      body: GetBuilder<homacontrollerimp>(
        builder: (controller) => IndexedStack(
          index: controller.currentTabicon,
          children: [
            Column(
              children: [
                Usergreetingbar(),
                SizedBox(height: 40),
                Expanded(
                  child: GetBuilder<homacontrollerimp>(
                    builder: (controller) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.changeTab(0);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                      color: controller.currentTab == 0
                                          ? AppColors.black
                                          : AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: controller.currentTab == 0 ? 90 : 0,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: controller.currentTab == 0
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
                                controller.changeTab(1);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                      color: controller.currentTab == 1
                                          ? AppColors.black
                                          : AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: controller.currentTab == 1 ? 90 : 0,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: controller.currentTab == 1
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
                          child: controller.currentTabicon == 0
                              ? controller.pages[controller.currentTab]
                              : controller.pagesicon[controller.currentTabicon -
                                    1],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            myorder(),
            myprofile(),
            Favorite(),
          ],
        ),
      ),
    );
  }
}
