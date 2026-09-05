import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/orders/orders.datasource.dart';
import 'package:ecommerce/data/models/Orders/Orde_Model.dart';
import 'package:ecommerce/view/bottom_navigation/tapsorder/Myhistory.dart';
import 'package:ecommerce/view/bottom_navigation/tapsorder/order.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';

abstract class BottomNavigationController extends GetxController {
  void changePage(int index);
  Future<void> loadOrders();
  String formatLanguage(String arabicText, String englishText);
}

class BottomNavigationControllerImp extends BottomNavigationController {
  final List<Widget> tabs = const [OrderTabView(), OrderHistoryTab()];
  final List<OrderModel1> ordersList = [];

  late final Orders ordersService;
  final Myservice myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    ordersService = Orders(crud());
    loadOrders();
  }

  @override
  void changePage(int index) {
    currentIndex = index;
    update();
  }

  @override
  Future<void> loadOrders() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final response = await ordersService.Getorders(
        myServices.sharedPreferences.getString('id')!,
      );

      if (response == StatusRequest.offlinefailure) {
        statusRequest = StatusRequest.offlinefailure;
        update();
        return;
      }

      if (response['status'] == 'success') {
        statusRequest = StatusRequest.success;
        final orders = response['data'] as List;
        ordersList.clear();
        ordersList.addAll(orders.map((item) => OrderModel1.fromJson(item)));
      } else {
        statusRequest = StatusRequest.exeption;
      }

      update();
    } catch (e) {
      statusRequest = StatusRequest.exeption;
      update();
      print('loadOrders error: $e');
    }
  }

  @override
  String formatLanguage(String arabicText, String englishText) {
    final language = myServices.sharedPreferences.getString('lang') ?? 'en';
    return language == 'ar' ? arabicText : englishText;
  }
}
