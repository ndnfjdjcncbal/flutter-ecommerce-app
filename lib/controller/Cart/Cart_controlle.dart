import 'dart:async';

import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/data/model/getitems_model/getitems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/statusrequest.dart';
import '../../core/counstant/colore.dart';
import '../../core/servises/Mysevice.dart';
import '../../data/datasource/car/cart.dart';
import '../../data/model/cartmodel.dart';
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
    update();
    var response = await cart.insertcartf(
      myServices.sharedPreferences.getString("id")!,
      Item,
      color,
    );
    print(response);
    if (response['status'] == "success") {
      statusRequest = StatusRequest.success;
      viewcart();
      Get.snackbar(
        "Cart",
        "تمت الاضافة ف سلة المنتجات",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.backgroundGrey,
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
  Future<dynamic> viewcart() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cart.viewcartd(
      myServices.sharedPreferences.getString('id')!,
    );
    print("Car$response");
    if (response['status'] == "success") {
      statusRequest = StatusRequest.success;
      List data = response['data'];
      cartlist.clear();
      cartlist.addAll(data.map((e) => cartmodel.fromJson(e)).toList());
      countprice = (response['countallprice'] as num).toDouble();
      countitemprice = double.parse(
        response['data'][0]['countprice'],
      ).toDouble();
      selectedItems = List.generate(cartlist.length, (index1) => false);

      update();

      print(cartlist.map((e) => e.itemsName).toList());
    } else {
      Get.snackbar("Error", "No Data Available");
      statusRequest = StatusRequest.exeption;
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
    productargument.clear();
    for (var select = 0; select < cartlist.length; select++) {
      if (selectedItems[select] == true) {
        productargument.add(cartlist[select]);
        if (productargument.isNotEmpty) {
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
        }
      } else {
        Get.snackbar("Exeption", "No Cart has selected");
      }
    }

    update();
  }
}
