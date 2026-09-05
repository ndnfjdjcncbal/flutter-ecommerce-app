import 'package:ecommerce/controllers/Cart/favoritecontroler.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/favorite/favorite.dart';
import 'package:ecommerce/data/data_sources/home/getdata.dart';
import 'package:ecommerce/data/models/Search/Searchistory.dart';
import 'package:ecommerce/data/models/banner.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:ecommerce/view/bottom_navigation/favorite.dart';
import 'package:ecommerce/view/bottom_navigation/myorder.dart';
import 'package:ecommerce/view/bottom_navigation/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/HomeScreen/CategoryWidget.dart';
import '../../view/HomeScreen/HomeWidget.dart';

abstract class HomeController extends GetxController {
  Future<void> loadBanners();

  Future<void> loadItems();

  Future<void> loadCategories();

  Future<void> toggleFavorite(String itemId);

  void updateTabIndex(int index);

  void updateBannerIndex(int index);
}

class HomeControllerImpl extends HomeController {
  StatusRequest statusRequestCategory = StatusRequest.none;

  String color = '';

  final Color primary = const Color(0xFF5B4FD9);
  int selectedColorIndex = 0;
  int selectedLocationIndex = 0;

  Text changeColorType(index) {
    if (index == 'Dark Gray') {
      return const Text('black');
    } else if (index == 'Blush Pink') {
      return const Text('Blush Pink');
    } else if (index == 'Lavender') {
      return const Text('lavender');
    } else if (index == 'Baby Blue') {
      return const Text('Baby Blue');
    } else if (index == 'Beige') {
      return const Text('Beige');
    }
    selectedColorIndex = index;
    update();

    return const Text('black');
  }

  final List<String> colorNames = [
    'Dark Gray',
    'Lavender',
    'Baby Blue',
    'Beige',
    'Blush Pink',
  ];
  final List<String> locationNames = ['amsterdam', 'new york', 'holanda'];

  void updateLocation(int index) {
    selectedLocationIndex = index;
    update();
  }

  bool isSearching = false;
  int selectedFilter = 0;

  late final favorite favoriteService;

  final List<String> filters = ['All', 'Latest', 'Most Popular', 'Cheapest'];

  @override
  Future<void> toggleFavorite(String itemId) async {
    final response = await favoriteService.insertfavf(
      itemId,
      myServices.sharedPreferences.getString('id')!,
    );

    if (response['status'] == 'success') {
      Get.snackbar('Success', 'Added successfully');
      final controllerfav = Get.find<FavoriteControllerImp>();
      controllerfav.loadFavoriteItems();
    } else if (response['status'] == 'falire') {
      Get.snackbar('Success', 'Added successfully');
    }

    update();
  }

  final List<String> tabLabels = ['Home', 'Myorder', 'Favorite', 'Profile'];

  int currentTabIndex = 0;
  int currentBannerIndex = 0;
  int currentBottomNavIndex = 0;
  String bannerTitle = '';
  String itemPrice = '';
  String itemDescription = '';
  String itemDescriptionArabic = '';
  String itemName = '';
  String itemImage = '';

  final List<Searchhistory> searchHistory = [];

  final List<Widget> pages = [Homewidget(), CategoryWidget()];
  final List<Widget> bottomNavigationPages = [
    Favorite(),
    myprofile(),
    Myorder(),
  ];

  void goToNotifications() {
    Get.toNamed(approute.notifications);
  }

  void navigateToPage(int index) {
    if (index == 1) {
      Get.toNamed(approute.favorite);
      return;
    }
    if (index == 2) {
      Get.toNamed(approute.order);
      return;
    }
    if (index == 3) {
      Get.toNamed(approute.profile);
      return;
    }
    currentBottomNavIndex = index;
    update();
  }

  @override
  void updateTabIndex(int index) {
    currentTabIndex = index;
    update();
  }

  Myservice myServices = Get.find();

  void updateNavigationIndex(int index) {
    currentBottomNavIndex = index;
    update();
  }

  @override
  void updateBannerIndex(int index) {
    currentBannerIndex = index;
    update();
  }

  final List<dynamic> banners = [];
  final List<dynamic> items = [];
  final List<dynamic> categories = [];

  late final databanner bannerService;
  StatusRequest statusRequest = StatusRequest.none;
  late final getdata dataSource;

  @override
  Future<void> loadBanners() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final response = await dataSource.getdataf();
      if (response == StatusRequest.offlinefailure) {
        statusRequest = StatusRequest.offlinefailure;
        update();
        return;
      }

      if (response != null &&
          response['status'] == 'success' &&
          response['data']['status'] == 'success') {
        banners.clear();
        final bannerList = response['data']['data'];
        banners.addAll(bannerList);
        bannerTitle = response['data']['data'][0]['baner_text'];
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }

      update();
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print('loadBanners error: $e');
    }
  }

  @override
  Future<void> loadItems() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final response = await dataSource.getitems();
      if (response == StatusRequest.offlinefailure) {
        statusRequest = StatusRequest.offlinefailure;
        update();
        return;
      }

      if (response != null &&
          response['status'] == 'success' &&
          response['data']['status'] == 'success') {
        items.clear();
        final itemList = response['data']['data'];
        items.addAll(itemList);
        itemPrice = response['data']['data'][0]['items_price'];
        itemDescription = response['data']['data'][0]['items_desc'];
        itemDescriptionArabic = response['data']['data'][0]['items_descAr'];
        itemName = response['data']['data'][0]['items_name'];
        itemImage = response['data']['data'][0]['items_image'];
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
      }

      update();
    } catch (e) {
      statusRequest = StatusRequest.offlinefailure;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    dataSource = getdata(crud());
    bannerService = databanner();
    loadBanners();
    loadItems();
    loadCategories();
    favoriteService = favorite(crud());
  }

  @override
  Future<void> loadCategories() async {
    try {
      statusRequestCategory = StatusRequest.loading;
      update();

      final response = await dataSource.getcategory();
      if (response == StatusRequest.offlinefailure) {
        statusRequestCategory = StatusRequest.offlinefailure;
        update();
        return;
      }

      if (response != null &&
          response['status'] == 'success' &&
          response['data']['status'] == 'success') {
        categories.clear();
        final categoryList = response['data']['data'];
        categories.addAll(categoryList);
        statusRequestCategory = StatusRequest.success;
      } else {
        statusRequestCategory = StatusRequest.failure;
      }

      update();
    } catch (e) {
      statusRequestCategory = StatusRequest.offlinefailure;
      update();
      print('loadCategories error: $e');
    }
  }
}
