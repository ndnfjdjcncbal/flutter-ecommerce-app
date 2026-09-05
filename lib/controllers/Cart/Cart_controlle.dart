import 'dart:async';

import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/car/cart.dart';
import 'package:ecommerce/data/models/cartmodel.dart';
import 'package:ecommerce/data/models/getitems_model/getitems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/statusrequest.dart';
import '../../core/constants/colore.dart';

import '../../view/approute.dart';

abstract class CartControlle extends GetxController {
  insertintocontroller(String item);

  viewcart();

  getSelectedCartItems();
}

class Cartcontrollerump extends CartControlle {
  double sum = 0;

  double countprice = 0;
  double shipping = 50;
  double discount = 0;
  double countitemprice = 0;

  String id = "";
  double finalprice = 0;
  TextEditingController cupon = TextEditingController();

  Future<dynamic> increaseQuantity(String Item, String color) async {
    var response = await cart.insertcartf(
      myServices.sharedPreferences.getString("id")!,
      Item,
      color,
    );
    print(response);
    if (response['status'] == "success") {
      Get.toNamed(approute.cart);
      statusRequest = StatusRequest.success;
      viewcart();
      Get.snackbar(
        "Cart",
        "تمت الاضافة ف سلة المنتجات",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      Get.toNamed(approute.cart);
    } else {
      statusRequest = StatusRequest.failure;
      update();
      Get.snackbar(
        "Cart",
        "Wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.newBadge,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
    }
    update();
  }

  TextEditingController promo = TextEditingController();
  List<cartmodel> cartlist = [];
  List<bool> selectedItems = [];
  late int index1 = cartlist.length;
  late itemsmodelall items;
  late Cart cart;
  StatusRequest statusRequest = StatusRequest.none;
  Myservice myServices = Get.find();

  toggleItem(int index, bool value) {
    selectedItems[index] = value;
    if (value == true) {
      index1 = index.round();
      double sum = 0;

      update();
    }
    update();
  }

  double getSelectedSubtotal() {
    double sum = 0;
    for (int i = 0; i < cartlist.length; i++) {
      if (selectedItems[i] == true) {
        sum += double.tryParse(cartlist[i].countprice ?? '0') ?? 0;
      }
    }
    return sum;
  }

  double getSelectedSubtotalwithshiping() {
    double sum = 0;
    for (int i = 0; i < cartlist.length; i++) {
      if (selectedItems[i] == true) {
        sum += double.tryParse(cartlist[i].countprice ?? '0') ?? 0;
      }
    }
    sum += shipping.toDouble();

    return sum;
  }

  @override
  void onInit() {
    cart = Cart(crud());
    viewcart();

    promo = TextEditingController();
    super.onInit();
  }

  insertintocontroller(String item) {}

  @override
  @override
  Future<dynamic> viewcart() async {
    cartlist.clear();
    selectedItems.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await cart.viewcartd(
      myServices.sharedPreferences.getString('id')!,
    );
    print("Car$response");

    if (response['status'] == "success") {
      List data = response['data'];

      if (data.isEmpty) {
        statusRequest = StatusRequest.success;
        countprice = 0;
        countitemprice = 0;
        cartlist.clear();
        selectedItems.clear();
      } else {
        statusRequest = StatusRequest.success;
        cartlist.clear();
        cartlist.addAll(data.map((e) => cartmodel.fromJson(e)).toList());
        countprice = (response['countallprice'] as num?)?.toDouble() ?? 0;
        countitemprice = double.tryParse(data[0]['countprice'].toString()) ?? 0;
        selectedItems = List.generate(cartlist.length, (index1) => false);
      }
    } else {
      statusRequest = StatusRequest.failure;
      countprice = 0;
      countitemprice = 0;
      cartlist.clear();
      selectedItems.clear();
    }

    update();
  }

  cupondiscount(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cart.cupondetails(id, cupon.text);
    print("CouponDiscount$response");
    print(response.runtimeType);

    print(response['data'].runtimeType);

    print(response['data']['data'].runtimeType);
    if (response['status'] == "success") {
      statusRequest = StatusRequest.success;

      update();

      discount =
          double.tryParse(
            response['data']['data'][0]['coupon_discount'].toString(),
          ) ??
          0;

      discount = countprice * (discount.toDouble() / 100.0);
      finalprice = countprice - discount;
      id = (response['data']['data'][0]['cupon_id']).toString();
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  double getTotalPrice() {
    return (finalprice > 0 ? finalprice : countprice) + shipping;
  }

  List<cartmodel> productargument = [];

  getSelectedCartItems() {
    productargument = [];

    for (var index = 0; index < cartlist.length; index++) {
      if (selectedItems[index] == true) {
        productargument.add(cartlist[index]);
      }
    }

    if (productargument.isEmpty) {
      Get.snackbar("Exception", "No product selected");
      update();
      return;
    }

    Get.toNamed(
      approute.paymentandviewaddres,
      arguments: {
        "items": productargument,
        "shipping": shipping,
        "subtotal": getSelectedSubtotal(),
        "totalprice": getSelectedSubtotalwithshiping(),
        "discount": discount,
        "cuponid": id,
      },
    );

    update();
  }
}
