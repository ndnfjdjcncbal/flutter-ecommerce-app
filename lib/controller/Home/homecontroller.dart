import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/servises/Mysevice.dart';
import '../../data/datasource/favorite/favorite.dart';
import '../../data/datasource/home/getdata.dart';
import '../../data/model/Search/Searchistory.dart';
import '../../data/model/banner.dart';
import '../../view/scren/BottomNavBarHome/favorite.dart';
import '../../view/scren/BottomNavBarHome/myorder.dart';
import '../../view/scren/BottomNavBarHome/profile.dart';
import '../../view/scren/HomeScreen/CategoryWidget.dart';
import '../../view/scren/HomeScreen/HomeWidget.dart';

abstract class homacontroller extends GetxController {
  getbanner();

  getitemsf();

  getcategoryf();

  addfav(String itemid);

  changeTab(int index);

  changeTab1(int index);
}

class homacontrollerimp extends homacontroller {
  String color = '';

  Color primary = Color(0xFF5B4FD9);
  int isselected = 0;
  int locationselected = 0;

  Text chnagtypecolor(index) {
    if (index == "Dark Gray") {
      return Text("black");
    } else if (index == 'Blush Pink') {
      return Text("Blush Pink");
    } else if (index == 'Lavender') {
      return Text("lavender");
    } else if (index == "Baby Blue") {
      return Text("Baby Blue");
    } else if (index == "Beige") {
      return Text("Beige");
    }
    isselected = index;
    update();

    return Text("black");
  }

  List<String> colorname = [
    "Dark Gray",
    "Lavender",
    "Baby Blue",
    "Beige",
    "Blush Pink",
  ];
  List<String> locationname = ["amsterdam", "new york", "holanda"];

  void chnagelocation(index) {
    locationselected = index;
    update();
  }

  bool isSearching = false;
  int selectedFilter = 0;

  late favorite addFav;

  List<String> filters = ["All", "Latest", "Most Popular", "Cheapest"];

  @override
  addfav(itemid) async {
    var response = await addFav.insertfavf(
      itemid,
      myServices.sharedPreferences.getString("id")!,
    );
    print(response);
    if (response['status'] == 'success') {
      Get.snackbar("Success", "Added Successfly");
    } else {
      if (response['status'] == 'falire') {
        Get.snackbar("success", "ADDED SUCCUSFLE");
      }
    }
    update();
  }

  List<String> texticon = ["Home", "Myorder", "Favorite", "Profile"];

  List<Widget> iconsss = [
    Icon(Icons.home_filled),
    Icon(Icons.shopping_bag_outlined),
    Icon(Icons.favorite_outline),
    Icon(Icons.person),
  ];
  int currentTab8 = 0;

  int currentTab = 0;
  int currentTab5 = 0;
  String text = "";
  String price = "";
  String desc = "";
  String descar = "";
  String name = "";
  String image = "";

  List<Searchhistory> historysearch = [];

  List<Widget> pages = [Homewidget(), CategoryWidget()];
  List<Widget> pagesicon = [Favorite(), myprofile(), myorder()];

  gotopage<Void>(int index) {
    if (index == 1) {
      Get.toNamed(approute.order);
      return;
    }
    if (index == 2) {
      Get.toNamed(approute.profile);
      return;
    }
    if (index == 3) {
      Get.toNamed(approute.favorite);
      return;
    }
    currentTabicon = index;
    update();
  }

  @override
  changeTab(int index) {
    currentTab = index;
    update();
  }

  Myservice myServices = Get.find();

  int currentTab1 = 0;
  int currentTabicon = 0;

  iconchnage(index) {
    currentTabicon = index;
    update();
  }

  changeTab1(int index) {
    currentTab1 = index;
    update();
  }

  List information = [];
  List itemsl = [];
  List categoryl = [];

  late databanner banner;
  StatusRequest statusRequest = StatusRequest.none;
  late getdata data;

  @override
  getbanner() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.getdataf();
    print(response);
    if (response != null &&
        response['status'] == "success" &&
        response['data']['status'] == 'success') {
      information.clear();

      List bannerList = response['data']['data'];
      information.addAll(bannerList);
      text = response['data']['data'][0]['baner_text'];
      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure;

      if (response == null && response['status'] == "faliure") {
        update();
      }
    }
    update();
  }

  getitemsf() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.getitems();
    print(response);
    if (response != null &&
        response['status'] == "success" &&
        response['data']['status'] == 'success') {
      itemsl.clear();

      List bannerList1 = response['data']['data'];
      itemsl.addAll(bannerList1);
      price = response['data']['data'][0]['items_price'];
      desc = response['data']['data'][0]['items_desc'];
      descar = response['data']['data'][0]['items_descAr'];
      name = response['data']['data'][0]['items_name'];
      image = response['data']['data'][0]['items_image'];

      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure;

      if (response == null && response['status'] == "faliure") {
        update();
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    data = getdata((crud()));
    banner = databanner();
    getbanner();
    getitemsf();
    getcategoryf();
    addFav = favorite((crud()));
  }

  @override
  getcategoryf() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.getcategory();
    print(response);
    if (response != null &&
        response['status'] == "success" &&
        response['data']['status'] == 'success') {
      categoryl.clear();

      List bannerList2 = response['data']['data'];
      categoryl.addAll(bannerList2);

      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure;

      if (response == null && response['status'] == "faliure") {
        update();
      }
    }
    update();
  }
}
