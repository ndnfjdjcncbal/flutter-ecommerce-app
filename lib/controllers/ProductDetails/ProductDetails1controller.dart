import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/car/cart.dart';
import 'package:ecommerce/data/models/cartmodel.dart';
import 'package:ecommerce/data/models/favorite/allfavorite.dart';
import 'package:ecommerce/data/models/getitems_model/getitems.dart';
import 'package:ecommerce/data/models/itemscolormodel.dart';
import 'package:ecommerce/core/constants/app_links/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/crud.dart';
import '../../core/classes/statusrequest.dart';
import '../../core/constants/App_color/colore.dart';

abstract class ProductDetailsController extends GetxController {
  Future<void> viewcoloritem(String item);
}

class ProductDetailsControllerImp extends ProductDetailsController {
  late itemsmodelall model;
  StatusRequest statusRequest = StatusRequest.none;
  late final Cart cart;
  final Myservice myServices = Get.find();

  int selectedColor = 0;
  int quantity = 1;
  String color = '';
  bool isAddingToCart = false;

  late cartmodel cartModel;
  List<cartmodel> cartItems = [];
  late colormodelitems colorsModel;
  List<itemsmodelall> colorItems = [];
  List indexColor = [''];
  int countColor = 0;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments is itemsmodelall) {
      model = arguments;
    } else if (arguments is modalallfavorite) {
      model = itemsmodelall.fromJson(arguments.toJson());
    } else {
      throw ArgumentError(
        'ProductDetails requires an itemsmodelall or modalallfavorite argument',
      );
    }

    cart = Cart(crud());
    cartModel = cartmodel();
    colorsModel = colormodelitems();

    final itemId = model.itemsId;
    if (itemId != null && itemId.isNotEmpty) {
      viewcoloritem(itemId);
    }

    super.onInit();
  }

  void selectColor(int itemColorId) {
    for (final colorItem in colorItems) {
      if (colorItem.itemscolorId == itemColorId.toString()) {
        countColor = int.parse(colorItem.itemscolorQuantity ?? '0');
        selectedColor = itemColorId;
        update();
        return;
      }
    }
  }

  Future<void> increaseQuantity(String item, String selectedColorValue) async {
    final userId = myServices.sharedPreferences.getString('id');
    if (userId == null || userId.isEmpty) {
      Get.snackbar('Cart', 'Please login first');
      return;
    }

    isAddingToCart = true;
    update();

    final response = await cart.insertcartf(userId, item, selectedColorValue);

    if (response['status'] == 'success') {
      isAddingToCart = false;
      update();
      Get.snackbar(
        'Cart',
        'تمت الاضافة ف سلة المنتجات',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      Get.toNamed(approute.cart);
      return;
    }

    isAddingToCart = false;
    update();
    Get.snackbar(
      'Cart',
      'Wrong',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.newBadge,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error_outline, color: Colors.white),
    );
  }

  Future<void> decreaseQuantity(String item) async {
    if (quantity <= 1) {
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    final response = await cart.deletecart(
      myServices.sharedPreferences.getString('id')!,
      item,
    );

    if (response['status'] == 'success') {
      quantity = response['data']['countitem'];
      final cartData = [response['data']];
      cartItems.clear();
      cartItems.addAll(cartData.map((e) => cartmodel.fromJson(e)));

      Get.snackbar(
        'Cart',
        'تمت الازالة من سلة المنتجات',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.backgroundGrey,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
    } else {
      statusRequest = StatusRequest.success;
      update();
      Get.snackbar(
        'Cart',
        'Wrong',
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

  void addToCart() {}
  void toggleFavorite() {}

  @override
  Future<void> viewcoloritem(String item) async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await cart.viewcoloritem(item);

    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      final data = response['data'] as List;
      colorItems = data.map((e) => itemsmodelall.fromJson(e)).toList();

      if (colorItems.isNotEmpty) {
        final firstColorId = int.tryParse(colorItems.first.itemscolorId ?? '');
        if (firstColorId != null) {
          selectColor(firstColorId);
        }
      }
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  Color viewcolor(dynamic type) {
    if (type == 'Baby Blue' || type == 'أزرق فاتح') {
      return const Color(0xFFD6E9F7);
    }
    if (type == 'Beige' || type == 'بيج') {
      return const Color(0xFFE8D9AE);
    }
    if (type == 'Dark Gray' || type == 'رمادي غامق') {
      return const Color(0xFF2C2C2C);
    }
    if (type == 'Blush Pink' || type == 'وردي فاتح') {
      return const Color(0xFFF4D9D7);
    }
    if (type == 'Lavender' || type == 'بنفسجي فاتح') {
      return const Color(0xFFD9CBEF);
    }
    return const Color(0xFF2C2C2C);
  }
}
