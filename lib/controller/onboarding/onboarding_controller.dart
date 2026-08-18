import 'package:ecommerce/view/approute.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/servises/Mysevice.dart';

class onboardingcon extends GetxController {
  int currentpage = 0;
  Myservice myServices = Get.find();
  late PageController pageController;

  updatepage(index) {
    currentpage = index;

    update();
  }

  updatepage1() async {
    currentpage++;

    if (currentpage > pages.length - 1) {
      myServices.sharedPreferences.setString("Step", "0");
      Get.toNamed(approute.login);
    } else {
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentpage,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  List<Map<String, String>> pages = [
    {"image": "assets/image1.png", "title": "2".tr, "subtitle": "3".tr},
    {"image": "assets/image2.png", "title": "4".tr, "subtitle": "5".tr},
    {"image": "assets/image3.png", "title": "6".tr, "subtitle": "7".tr},
  ];

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
