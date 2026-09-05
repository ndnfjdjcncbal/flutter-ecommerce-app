import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/address/addres.dart';
import 'package:ecommerce/data/models/addres/addres.dart';
import 'package:get/get.dart';

import '../../core/classes/statusrequest.dart';

import '../../view/approute.dart';

abstract class AddressController extends GetxController {
  void selectAddress(int index);
  Future<void> viewaddres();
  void goToMap();
  void onAddressSelected(int index);
}

class AddressControllerImp extends AddressController {
  final List<addresmodel> addresview = [];
  late final Addres addresdata;
  final Myservice myServices = Get.find();

  int selectedAddress = 0;
  StatusRequest statusRequest = StatusRequest.none;

  void gettoviewaddresandpayment(String addressId) {
    Get.back(result: addressId);
  }

  @override
  void onInit() {
    addresdata = Addres(crud());
    viewaddres();
    super.onInit();
  }

  @override
  void selectAddress(int index) {
    selectedAddress = index;
    update();
  }

  @override
  Future<void> viewaddres() async {
    statusRequest = StatusRequest.loading;
    update();

    addresview.clear();

    final response = await addresdata.viewaddresf(
      myServices.sharedPreferences.getString('id')!,
    );

    if (response['status'] == 'success') {
      statusRequest = StatusRequest.success;
      final data = response['data'] as List;
      addresview.addAll(
        data.map((item) => addresmodel.fromJson(item)).toList(),
      );
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  void goToMap() {
    Get.toNamed(approute.Mappage);
  }

  @override
  void onAddressSelected(int index) {
    selectAddress(index);
    if (index < addresview.length) {
      gettoviewaddresandpayment(addresview[index].addresId!);
    }
  }

  String getMapUrl(int index) {
    const mapUrls = [
      'https://img.freepik.com/free-vector/city-map-navigation-concept_23-2148293529.jpg',
      'https://img.freepik.com/free-vector/map-navigation-concept_23-2148293528.jpg',
      'https://img.freepik.com/free-vector/map-location-isometric-concept_23-2148293530.jpg',
    ];
    return mapUrls[index % mapUrls.length];
  }
}
