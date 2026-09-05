import 'dart:async';
import 'package:ecommerce/controllers/payment_integration/payment_controller.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/paymentRequest.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/address/addres.dart';
import 'package:ecommerce/data/data_sources/checkout/checkout.dart';
import 'package:ecommerce/data/data_sources/payment/getnumbercart.dart';
import 'package:ecommerce/data/models/addres/addres.dart';
import 'package:ecommerce/data/models/cartmodel.dart';
import 'package:ecommerce/data/models/payment_model.dart';

import 'package:ecommerce/view/approute.dart';
import 'package:ecommerce/view/widget/orders/SuccessCheckoutBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/classes/statusrequest.dart';

import '../Addres/addres_controller.dart';

class ViewproductandaddrseController extends GetxController {
  bool isaddorderdone = false;
  AddressControllerImp addressController = Get.put(AddressControllerImp());

  List<String> orderTypes = ['resent', 'delivery'];
  List<String> paymentTypes = ['pay Now', 'paymentMethod'];

  final orderTypeSelected = ValueNotifier<String?>(null);
  final paymentTypeSelected = ValueNotifier<String?>(null);

  String idindexaddress = "";
  late Checkout checkout;
  List<cartmodel> productselected = [];
  String idorder = "";

  String Country = "";
  String City = "";
  String Street = "";

  double shipping = 0;
  double subtotal = 0;
  double totalPrice = 0;
  double discount = 0;
  String cuponId = "";

  late Addres addres;
  late Payment payment;

  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestOrder = StatusRequest.none;
  StatusRequest statusRequestlatestnumber = StatusRequest.none;

  Myservice myServices = Get.find();
  Set<cardmodel> seenFingerprints = {};
  int selectedIndex = -1;
  addresmodel? selected;
  @override
  void onInit() {
    addres = Addres(crud());
    checkout = Checkout(crud());
    payment = Payment(crud());

    var args = Get.arguments;
    if (args != null) {
      productselected = List<cartmodel>.from(args["items"] ?? []);
      shipping = args['shipping'] ?? 0;
      subtotal = (args['subtotal'] as num?)?.toDouble() ?? 0;
      totalPrice = (args['totalprice'] as num?)?.toDouble() ?? 0;
      discount = (args['discount'] as num?)?.toDouble() ?? 0;
      cuponId = args['cuponid']?.toString() ?? "";
      print(productselected);
      print("$shipping, $subtotal, $totalPrice, $discount, $cuponId");
      /////////////////////////////////////////////////////////////
      idindexaddress = args['addressId']?.toString() ?? "";
    }

    viewlatetsaddresf();
    getlatestnumber();
    super.onInit();
  }

  bool get hasRequiredSelections =>
      orderTypeSelected.value != null && paymentTypeSelected.value != null;

  bool hasSelectedValidPaymentMethod() {
    if (paymentTypeSelected.value != "paymentMethod") return true;
    return selectedIndex >= 0 && selectedIndex < seenFingerprints.length;
  }

  String? validateCheckoutSelection(Payment0000 paymentController) {
    if (orderTypeSelected.value == null) {
      return "Please choose the order type first";
    }
    if (paymentTypeSelected.value == null) {
      return "Please choose the payment type first";
    }
    if (paymentTypeSelected.value == "paymentMethod" &&
        !hasSelectedValidPaymentMethod()) {
      return "Please select a saved payment method first";
    }
    if (paymentTypeSelected.value == "pay Now" &&
        !paymentController.ispaymentdone) {
      return "Please complete the payment first";
    }
    return null;
  }

  String get paymentSelectionMessage {
    if (paymentTypeSelected.value == "paymentMethod" &&
        !hasSelectedValidPaymentMethod()) {
      return "Please select a saved payment method first";
    }
    return "Please make a valid selection";
  }

  String get missingSelectionMessage {
    if (orderTypeSelected.value == null && paymentTypeSelected.value == null) {
      return "Please choose the order type and payment type first";
    }
    if (orderTypeSelected.value == null) {
      return "Please choose the order type first";
    }
    if (paymentTypeSelected.value == null) {
      return "Please choose the payment type first";
    }
    return "Please make a valid selection";
  }

  void updateOrderType(String? val) {
    orderTypeSelected.value = val;
  }

  void updatePaymentType(String? val) {
    paymentTypeSelected.value = val;
    if (val == "pay Now") {
      selectedIndex = -1;
    }
    update();
  }

  Future<void> goToAddressPage() async {
    var result = await Get.toNamed(approute.addressPage);
    if (result != null) {
      idindexaddress = result.toString();
      update();
      await viewlatetsaddresf();
    }
  }

  var savedAddresses = [];
  Future<void> viewlatetsaddresf() async {
    try {
      final savedAddresses =
          myServices.sharedPreferences.getStringList('Addresses') ?? [];
      if (savedAddresses.isNotEmpty) {
        myServices.sharedPreferences.getStringList("Addresses");
        Country = savedAddresses[0];
        City = savedAddresses[1];
        Street = savedAddresses[2];
        idorder = savedAddresses[3];
        print(City);
        print(Street);
      }

      statusRequest = StatusRequest.loading;
      update();

      var response = await addres.viewlatestaddres(
        myServices.sharedPreferences.getString('id')!,
      );

      if (response['status'] == "success") {
        statusRequest = StatusRequest.success;

        if (idindexaddress.isEmpty && savedAddresses.isEmpty) {
          Country = response['data'][0]['addres_country'].toString();
          Street = response['data'][0]['addres_street'].toString();
          City = response['data'][0]['addres_city'].toString();
          idorder = response['data'][0]['addres_id'].toString();
        } else {
          await addressController.viewaddres();
          var selected = addressController.addresview.firstWhereOrNull(
            (e) => e.addresId == idindexaddress,
          );
          if (selected != null) {
            Country = selected.addresCountry!;
            City = selected.addresCity!;
            Street = selected.addresStreet!;
            idorder = selected.addresId!;
            myservice.sharedPreferences.getStringList('Addresses')?.clear();
            var Addresses = myServices.sharedPreferences.setStringList(
              'Addresses',
              [Country, City, Street, idorder],
            );
            print(Addresses);
            update();
            return;
          } else {
            myServices.sharedPreferences.getStringList("Addresses");
            Country = savedAddresses[0];
            City = savedAddresses[1];
            Street = savedAddresses[2];
            idorder = savedAddresses[3];
            update();
          }
        }
      } else {
        statusRequest = StatusRequest.failure;
        Get.snackbar("Error", "Failed to fetch address data");
      }
      update();
    } catch (e) {
      statusRequest = StatusRequest.exeption;
      Exception(e.toString());
      update();
    }
  }

  void onCheckoutPressed(Payment0000 paymentController) {
    final validationMessage = validateCheckoutSelection(paymentController);
    if (validationMessage != null) {
      Get.snackbar(
        "Required",
        validationMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    addOrder(
      orderType: orderTypeSelected.value.toString(),
      paymentMethod: _formatPaymentMethod(),
    );
  }

  String _formatPaymentMethod() {
    if (paymentTypeSelected.value == "pay Now") return "pay now";
    final cards = seenFingerprints.toList();
    if (cards.isNotEmpty && selectedIndex < cards.length) {
      return "paymentMethod With ${cards[selectedIndex].last4}";
    }
    return "";
  }

  addOrder({required String orderType, required String paymentMethod}) async {
    if (productselected.isEmpty) return;

    statusRequestOrder = StatusRequest.loading;
    update();

    List<String> ids = productselected.map((e) => e.itemsId!).toList();

    var response = await checkout.addorder(
      myServices.sharedPreferences.getString('id')!,
      idorder,
      orderType,
      paymentMethod,
      subtotal.toString(),
      shipping.toString(),
      totalPrice.toString(),
      ids.length.toString(),
      ids.join(","),
      cuponId,
      discount.toString(),
    );

    if (response['status'] == 'success') {
      statusRequestOrder = StatusRequest.success;
      productselected.clear();
      _showSuccessCheckout();
    } else {
      statusRequestOrder = StatusRequest.failure;
      Get.snackbar("Error", response['Error'] ?? "Failed to place order");
    }
    update();
  }

  void _showSuccessCheckout() {
    Get.bottomSheet(
      const SuccessCheckoutBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Set Uniquecard = {};
  getlatestnumber() async {
    statusRequestlatestnumber = StatusRequest.loading;
    update();
    try {
      var response = await payment.viewlatestnumber(
        myServices.sharedPreferences.getString('id')!,
      );
      print(response);

      final rawCards = response is Map ? response['card'] : null;
      final List<dynamic> cards = rawCards is List ? rawCards : const [];

      seenFingerprints.clear();

      if (response['status'] == "success") {
        statusRequestlatestnumber = StatusRequest.success;

        if (cards.isNotEmpty) {
          seenFingerprints.addAll(
            cards.map((card) => cardmodel.fromJson(card)).toSet(),
          );
        }
      } else {
        statusRequestlatestnumber = StatusRequest.offlinefailure;
      }
    } catch (w) {
      statusRequestlatestnumber = StatusRequest.exeption;
      return Exception(w);
    }
    update();
  }

  void selectPayment(int index) {
    selectedIndex = index;
    update();
  }

  String formatimage(String brand) {
    if (brand.toLowerCase() == 'visa') return "assets/visa.png";
    if (brand.toLowerCase() == 'mastercard') return "assets/mastercard4.png";
    return "assets/card.png";
  }

  void validateAndPay(Payment0000 paymentController) {
    if (productselected.isEmpty) return;
    if (!hasRequiredSelections) {
      Get.snackbar(
        "Required",
        "Please choose the order type first before checkout",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }
}
