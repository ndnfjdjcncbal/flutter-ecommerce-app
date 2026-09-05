import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/data/data_sources/favorite/favorite.dart';
import 'package:ecommerce/data/data_sources/getitems_for_category/getitems_for_category.dart';

import 'package:ecommerce/data/models/getitems_model/getitems.dart';
import 'package:get/get.dart';

class GetitemsForCategoryController extends GetxController {
  late GetitemsForCategoryData data;
  late favorite addFav;

  StatusRequest statusRequest = StatusRequest.none;
  final Myservice myServices = Get.find();
  String categoryId = '';
  String categoryName = 'Category';
  List<dynamic> responseItems = [];
  List<itemsmodelall> items = [];

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    categoryId = (arguments['categoryId'] ?? '').toString();
    categoryName = (arguments['categoryName'] ?? 'Category').toString();

    data = GetitemsForCategoryData(crud());
    addFav = favorite(crud());
    getItems();
  }

  Future<void> getItems() async {
    statusRequest = StatusRequest.loading;
    update();

    responseItems.clear();
    items.clear();

    final response = await data.getItemsByCategory(categoryId);

    if (response != null && response['status'] == 'success') {
      responseItems = List<dynamic>.from(response['data'] ?? []);
      items = responseItems
          .map((item) => itemsmodelall.fromJson(item))
          .toList();
      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  Future<void> addFavorite(String itemId) async {
    final response = await addFav.insertfavf(
      itemId,
      myServices.sharedPreferences.getString('id')!,
    );

    if (response['status'] == 'success') {
      Get.snackbar('Success', 'Added Successfully');
    } else if (response['status'] == 'falire') {
      Get.snackbar('Success', 'Added Successfully');
    }
  }
}
