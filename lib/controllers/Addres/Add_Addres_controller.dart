import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/address/addres.dart';
import 'package:ecommerce/core/constants/app_links/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/classes/statusrequest.dart';

import '../CheckOut/checkout_controller.dart';

abstract class AddaddresController extends GetxController {
  AddAddres();
}

class AddaddresControllerImp extends AddaddresController {
  ViewproductandaddrseController co =
      Get.find<ViewproductandaddrseController>();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController street = TextEditingController();

  String? lat;
  String? lon;

  @override
  void onClose() {
    country.dispose();
    city.dispose();
    street.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    country = TextEditingController();
    city = TextEditingController();
    street = TextEditingController();

    addresdata = Addres(crud());
    lat = Get.arguments['lat'].toString();
    lon = Get.arguments['lon'].toString();

    super.onInit();
  }

  int selectedAddress = -1;
  StatusRequest statusRequest = StatusRequest.none;

  late Addres addresdata;
  Myservice myServices = Get.find();

  gettoaddressandpayment() async {
    Get.toNamed(
      approute.paymentandviewaddres,
      arguments: {
        "country": country.text,
        "city": city.text,
        "street": street.text,
        "lat": lat,
        "lon": lon,
      },
    );
    await co.viewlatetsaddresf();
  }

  @override
  AddAddres() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await addresdata.addAddress(
      userId: myServices.sharedPreferences.getString("id")!,
      country: country.text,
      city: city.text,
      street: street.text,
      lat: lat.toString(),
      long: lon.toString(),
    );
    print("============================== Addresses $response");
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      myServices.sharedPreferences.getStringList("Addresses")?.clear();
      myServices.sharedPreferences.setStringList("Addresses", [
        country.text,
        city.text,
        street.text,
        lat.toString(),
        lon.toString(),
      ]);
      gettoaddressandpayment();
    } else {
      statusRequest = StatusRequest.failure;

      Get.snackbar("Error", "Failed To Add Address");
      update();
    }

    update();
  }
}
