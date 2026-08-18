import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/classes/crud.dart';
import '../../core/classes/statusrequest.dart';
import '../../core/servises/Mysevice.dart';
import '../../data/datasource/favorite/favorite.dart';
import '../../view/scren/pagesfavorite/Allfavorite.dart';
import '../../view/scren/pagesfavorite/Cheapestfavorute.dart';
import '../../view/scren/pagesfavorite/latestfavorite.dart';
import '../../view/scren/pagesfavorite/mostpopularfaforite.dart';

abstract class FavoriteController extends GetxController {
  changeTab(int index);

  Searchitemfavorite(String itemname);

  onSearchSubmit(String query);

  viewfavnosearch();
}

class FavoriteControllerImp extends FavoriteController {
  onSearchSubmit(String query) {
    if (query.trim().isEmpty) {}
  }

  late favorite addFav;
  Myservice myServices = Get.find();

  int currentTab = 0;
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  List itemssearches = [];
  List latest = [];
  List cheapestdata = [];
  List Mostpopular = [];
  List mostpopularnofilter = [];

  final List<String> tabs = ["All", "Latest", "Most Popular", "Cheapest"];
  List<Widget> pages1 = [
    AllFavorite(),
    LatestFavorite(),
    MostPopularFavorite(),
    CheapestFavorite(),
  ];

  @override
  void changeTab(int index) {
    currentTab = index;
    update();
  }

  @override
  void onInit() {
    addFav = favorite((crud()));
    viewfavnosearch();

    super.onInit();
  }

  @override
  Searchitemfavorite(itemname) async {
    isSearching = true;
    statusRequest = StatusRequest.loading;
    update();
    var response = await addFav.viewtfavf(
      itemname,
      myServices.sharedPreferences.getString("id")!,
    );

    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      update();
      Mostpopular.clear();
      Mostpopular.addAll(response['datapop']);
      cheapestdata.clear();
      cheapestdata.addAll(response['Cheapestdata']);
      latest.clear();
      latest.addAll(response['datalate']);
      itemssearches.clear();
      itemssearches.addAll(response['alldata']);
    } else {
      if (response["status"] == 'failure') {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
    update();
  }

  @override
  viewfavnosearch() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addFav.viewtfavnosearchf();

    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      update();
      Mostpopular.clear();
      Mostpopular.addAll(response['datapop']);
      cheapestdata.clear();
      cheapestdata.addAll(response['Cheapestdata']);
      latest.clear();
      latest.addAll(response['datalate']);
      itemssearches.clear();
      itemssearches.addAll(response['alldata']);
    } else {
      if (response["status"] == 'failure') {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
    update();
  }
}
