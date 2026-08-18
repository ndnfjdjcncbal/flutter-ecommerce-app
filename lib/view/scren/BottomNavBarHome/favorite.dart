import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Cart/favoritecontroler.dart';

class Favorite extends StatelessWidget {
  Favorite({super.key});

  final FavoriteControllerImp controllerImp = Get.put(FavoriteControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 120),
                const Text(
                  "My Favorite",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none, size: 30),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),

            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 11),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.grey),
                borderRadius: BorderRadius.circular(13),
              ),
              child: TextField(
                controller: controllerImp.searchController,

                onChanged: (value) {
                  if (value.isEmpty) {
                    controllerImp.isSearching = false;
                    controllerImp.viewfavnosearch();
                  }
                },

                onSubmitted: controllerImp.onSearchSubmit,

                decoration: InputDecoration(
                  hintText: "Search something...",
                  hintStyle: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    padding: const EdgeInsets.only(bottom: 30),
                    icon: const Icon(Icons.search, size: 47),
                    onPressed: () {
                      controllerImp.onSearchSubmit(
                        controllerImp.Searchitemfavorite(
                          controllerImp.searchController.text,
                        ).toString(),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            GetBuilder<FavoriteControllerImp>(
              builder: (con) => SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controllerImp.tabs.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      controllerImp.changeTab(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      margin: const EdgeInsets.only(right: 9),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey, width: 0.5),
                        color: controllerImp.currentTab == index
                            ? AppColors.primary
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        controllerImp.tabs[index],
                        style: TextStyle(
                          color: controllerImp.currentTab == index
                              ? AppColors.white
                              : AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            GetBuilder<FavoriteControllerImp>(
              builder: (controller) => Handlingdataview(
                statusRequest: controller.statusRequest,
                widget: Expanded(
                  child: controller.isSearching
                      ? controller.pages1[controller.currentTab]
                      : controller.pages1[controller.currentTab],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
