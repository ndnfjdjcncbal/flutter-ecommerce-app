import 'package:ecommerce/core/classes/crud.dart';
import 'package:get/get.dart';

import '../../core/classes/statusrequest.dart';
import '../../core/servises/Mysevice.dart';
import '../../data/datasource/address/addres.dart';
import '../../data/model/addres/addres.dart';

abstract class AddressController extends GetxController {
  selectAddress(int index);

  viewaddres();
}

class AddressControllerImp extends AddressController {
  void gettoviewaddresandpayment(String addressId) {
    Get.back(result: addressId);
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    addresdata = Addres(crud());
    viewaddres();
    super.onInit();
  }

  int selectedAddress = 0;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void selectAddress(int index) {
    selectedAddress = index;
    update();
  }

  List<addresmodel> addresview = [];
  late Addres addresdata;
  Myservice myServices = Get.find();

  @override
  Future<dynamic> viewaddres() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addresdata.viewaddresf(
      myServices.sharedPreferences.getString('id')!,
    );
    print(response);

    if (response['status'] == "success") {
      statusRequest = StatusRequest.success;
      List view = response['data'];
      addresview.addAll(view.map((e) => addresmodel.fromJson(e)).toList());
      update();
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }
}
