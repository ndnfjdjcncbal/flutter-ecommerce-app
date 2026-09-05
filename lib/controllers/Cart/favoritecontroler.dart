import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/favorite/favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/classes/crud.dart';
import '../../core/classes/statusrequest.dart';

import '../../view/pagesfavorite/Allfavorite.dart';
import '../../view/pagesfavorite/Cheapestfavorute.dart';
import '../../view/pagesfavorite/latestfavorite.dart';
import '../../view/pagesfavorite/mostpopularfaforite.dart';

abstract class FavoriteController extends GetxController {
  void changeTab(int index);
  Future<void> searchFavoriteItems(String itemName);
  void handleSearchSubmit(String query);
  Future<void> loadFavoriteItems();
}

class FavoriteControllerImp extends FavoriteController {
  late final favorite favoriteService;
  final Myservice myServices = Get.find();

  int currentTab = 0;
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  final List<dynamic> allfavorite = [];
  final List<dynamic> latestItems = [];
  final List<dynamic> cheapestItems = [];
  final List<dynamic> mostPopularItems = [];

  final List<String> tabs = ['All', 'Latest', 'Most Popular', 'Cheapest'];
  final List<Widget> pages = [
    AllFavorite(),
    LatestFavorite(),
    MostPopularFavorite(),
    CheapestFavorite(),
  ];

  @override
  @override
  void changeTab(int index) {
    currentTab = index;
    update();
  }

  @override
  void handleSearchSubmit(String query) {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      isSearching = false;
      loadFavoriteItems();
      return;
    }

    isSearching = true;
    searchFavoriteItems(trimmedQuery);
  }

  @override
  void onInit() {
    favoriteService = favorite(crud());
    loadFavoriteItems();
    super.onInit();
  }

  @override
  Future<void> searchFavoriteItems(String itemName) async {
    try {
      isSearching = true;
      statusRequest = StatusRequest.loading;
      update();

      final response = await favoriteService.viewtfavf(
        itemName,
        myServices.sharedPreferences.getString('id')!,
      );

      if (response == StatusRequest.offlinefailure) {
        statusRequest = StatusRequest.offlinefailure;
        update();
        return;
      }

      if (response is! Map) {
        statusRequest = StatusRequest.offlinefailure;
        update();
        return;
      }

      if (response['status'] == 'success') {
        statusRequest = StatusRequest.success;
        mostPopularItems
          ..clear()
          ..addAll(response['datapop'] ?? const []);
        cheapestItems
          ..clear()
          ..addAll(response['Cheapestdata'] ?? const []);
        latestItems
          ..clear()
          ..addAll(response['datalate'] ?? const []);
        allfavorite
          ..clear()
          ..addAll(response['alldata'] ?? const []);
      } else {
        statusRequest = StatusRequest.failure;
      }

      update();
    } catch (e) {
      statusRequest = StatusRequest.exeption;
      update();
      print('searchFavoriteItems error: $e');
    }
  }

  @override
  Future<void> loadFavoriteItems() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final response = await favoriteService.viewtfavnosearchf();

      if (response == StatusRequest.offlinefailure) {
        statusRequest = StatusRequest.offlinefailure;
        update();
        return;
      }

      if (response['status'] == 'success') {
        statusRequest = StatusRequest.success;
        mostPopularItems
          ..clear()
          ..addAll(response['datapop'] ?? const []);
        cheapestItems
          ..clear()
          ..addAll(response['Cheapestdata'] ?? const []);
        latestItems
          ..clear()
          ..addAll(response['datalate'] ?? const []);
        allfavorite
          ..clear()
          ..addAll(response['alldata'] ?? const []);
      } else {
        statusRequest = StatusRequest.failure;
      }

      update();
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print('loadFavoriteItems error: $e');
    }
  }
}
