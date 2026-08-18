import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/servises/Mysevice.dart';
import 'package:ecommerce/data/datasource/payment/getnumbercart.dart';
import 'package:ecommerce/data/model/paymentmodael.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/classes/statusrequest.dart';
import '../../data/datasource/address/addres.dart';
import '../../data/datasource/checkout/checkout.dart';
import '../../data/model/addres/addres.dart';
import '../../data/model/addres/latetestaddres.dart';
import '../../data/model/cartmodel.dart';
import '../Addres/addres_controller.dart';

class ViewproductandaddrseController extends GetxController {
  AddressControllerImp controller = Get.put(AddressControllerImp());
  String idindexaddress = "";
  CameraPosition? kGooglePlex1;
  late Checkout checkout;
  List<cartmodel> productselected = [];
  String idorder = "";
  String? lat1;
  String? lon1;
  bool istrue = true;
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController street = TextEditingController();
  String Country = "";
  String City = "";
  String Street = "";
  List<String> IDs = [];
  late String items = IDs.join(",");

  double shipping = 0;
  double subtotal = 0;
  double totalPrice = 0;
  double discount = 0;
  String cuponId = "";

  late Addres addres;
  Geocoding geocoding = Geocoding();
  List<latetestaddres> latestaddres = [];
  List<addresmodel> addresview = [];

  @override
  @override
  void onInit() {
    addres = Addres(crud());
    checkout = Checkout(crud());

    var args = Get.arguments;
    print(Get.arguments);
    productselected = List<cartmodel>.from(args["items"]);
    shipping = args['shipping'];
    subtotal = (args['subtotal'] as num?)?.toDouble() ?? 0;
    totalPrice = (args['totalprice'] as num?)?.toDouble() ?? 0;
    discount = (args['discount'] as num?)?.toDouble() ?? 0;
    cuponId = args['cuponid']?.toString() ?? "";

    idindexaddress = args['addressId']?.toString() ?? "";
    viewlatetsaddresf();
    payment = Payment(crud());
    getlatestnumber();
    super.onInit();
  }

  StatusRequest statusRequest = StatusRequest.none;
  Myservice myServices = Get.find();

  changeAddress(String id) {
    print("changeAddress = $id");

    idindexaddress = id;
  }

  Future<dynamic> viewlatetsaddresf() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addres.viewlatestaddres(
      myServices.sharedPreferences.getString('id')!,
    );
    print(response);
    if (response['status'] == "success") {
      statusRequest = StatusRequest.success;
      List data = response['data'];
      latestaddres = data.map((e) => latetestaddres.fromJson(e)).toList();
      if (latestaddres.isEmpty) {
        Get.showSnackbar(GetSnackBar(title: "No address find "));
      }
      if (idindexaddress.isEmpty) {
        Country = response['data'][0]['addres_country'].toString();
        Street = response['data'][0]['addres_street'].toString();
        City = response['data'][0]['addres_city'].toString();
        idorder = response['data'][0]['addres_id'].toString();
      } else {
        print("Selected Id = $idindexaddress");
        controller.viewaddres();
        for (var e = 0; e < controller.addresview.length; e++) {
          print("API Id = ${controller.addresview[e].addresId}");

          if (controller.addresview[e].addresId == idindexaddress) {
            Country = controller.addresview[e].addresCountry!;
            City = controller.addresview[e].addresCity!;
            Street = controller.addresview[e].addresStreet!;
            idorder = controller.addresview[e].addresId!;
            break;
          }
        }
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  addOrder({required String orderType, required String paymentMethod}) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      print("Before API");
      for (var item in productselected) {
        IDs.add(item.itemsId!);
      }
      var response = await checkout.addorder(
        myServices.sharedPreferences.getString('id')!,
        idorder,
        orderType,
        paymentMethod,
        subtotal.toString(),
        shipping.toString(),
        totalPrice.toString(),
        "1",
        items,
        cuponId,
        discount.toString(),
      );

      print("After API");
      print("Response = $response");

      if (response['status'] == 'success') {
        statusRequest = StatusRequest.success;

        Get.snackbar("Successfully", "Order placed successfully");
      } else {
        if (response['Error'] == "لا يوجد منتجات داخل الكارت") {
          Get.snackbar("Error", "Failed to place order");
          statusRequest = StatusRequest.exeption;
        }
      }
    } catch (e, s) {
      print("Exception: $e");
      print(s);

      statusRequest = StatusRequest.failure;

      Get.snackbar("Exception", e.toString());
      print(e);
    }

    update();
  }

  String last0 = "";

  Myservice myservice = Get.find<Myservice>();
  List<cardmodel> data = [];
  late Payment payment;
  @override
  int selectedIndex = 0;

  void selectPayment(int index) {
    selectedIndex = index;
    update();
  }

  Set<cardmodel> seenFingerprints = {};

  getlatestnumber() async {
    var response = await payment.viewlatestnumber(
      myservice.sharedPreferences.getString('id')!,
    );
    print("Payment Method Data ${response}");
    if (response['status'] == "success") {
      List rawData = response['card'];
      seenFingerprints.clear();
      Set fingerprint = {};
      for (dynamic i = 0; i < rawData.length; i++) {
        dynamic numbercard = rawData[i]['fingerprint'];

        if (fingerprint.contains(numbercard)) {
          continue;
        } else {
          fingerprint.add(numbercard);
          seenFingerprints.add(cardmodel.fromJson(rawData[i]));
        }
      }
    }
    update();
  }

  String formatimage(String brand) {
    if (brand.toLowerCase() == 'visa') {
      return "assets/visa.png";
    }

    if (brand.toLowerCase() == 'mastercard') {
      return "assets/mastercard4.png";
    }

    return "assets/card.png";
  }
}
