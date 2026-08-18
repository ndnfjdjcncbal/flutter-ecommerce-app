import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/classes/crud.dart';
import '../../core/classes/statusrequest.dart';
import '../../core/counstant/colore.dart';
import '../../core/servises/Mysevice.dart';
import '../../data/datasource/Search/search.dart';
import '../../data/datasource/favorite/favorite.dart';
import '../../data/model/Search/Searchistory.dart';
import '../../data/model/Search/searchresult.dart';
import '../../data/model/Search/usersaves.dart';
import '../../view/scren/SearchScreen/Allsearch.dart';
import '../../view/scren/SearchScreen/Cheapest.dart';
import '../../view/scren/SearchScreen/latestsearh.dart';
import '../../view/scren/SearchScreen/mostpopular.dart';

abstract class SearchController extends GetxController {
  Searchitemsf(String itemname);

  FormatFilterhcount(dynamic count);

  historySearchitemsf(String itemnameE, String itemnameAR, String itemid);

  changeTab(int index);

  getsearchf();

  changeTab1(int index);

  clearhistory();

  deleteidistory(String user);

  getpopularsearchf();
}

class SearchControllerimp extends SearchController {
  late favorite addFav;

  @override
  addfav(itemid) async {
    var response = await addFav.insertfavf(
      itemid,
      myServices.sharedPreferences.getString("id")!,
    );
    print(response);
    if (response['status'] == 'success') {
      Get.snackbar("Success", "Added Successfly");
    } else {
      if (response['status'] == 'falire') {
        Get.snackbar("success", "ADDED SUCCUSFLE");
      }
    }
    update();
  }

  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onInit() {
    super.onInit();
    data = Search((crud()));
    search = (modelsearch());
    getsearchf();
    getpopularsearchf();
    saveUserChoicesf();
    addFav = favorite((crud()));
  }

  void updatevalues(newvalue) {
    values = newvalue;
    update();
  }

  void chnageselect(index) {
    isselected = index;
    update();
  }

  void chnagelocation(index) {
    locationselected = index;
    update();
  }

  void changeFilter(int index) {
    selectedFilter = index;
    update();
  }

  int currentTab8 = 0;

  int currentTab = 0;
  int currentTab5 = 0;
  String text = "";

  List<Searchhistory> historysearch = [];

  @override
  changeTab(int index) {
    currentTab = index;
    update();
  }

  Myservice myServices = Get.find();

  int currentTab1 = 0;

  StatusRequest statusRequest = StatusRequest.none;

  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isSearching = false;

  late Search data;
  late modelsearch search;

  List itemssearches = [];
  List latest = [];
  List cheapestdata = [];
  List Mostpopular = [];
  List mostpopularnofilter = [];

  List<String> filters = ["All", "Latest", "Most Popular", "Cheapest"];

  int selectedFilter = 0;

  List<Widget> pagessearch = [
    Allsearch(),
    latestsearch(),
    mostpopular(),
    cheapest(),
  ];

  RangeValues values = const RangeValues(10, 80);

  String color = '';

  int isselected = 0;
  int locationselected = 0;

  List<String> colorname = [
    "Dark Gray",
    "Lavender",
    "Baby Blue",
    "Beige",
    "Blush Pink",
  ];

  List<String> locationname = ["amsterdam", "new york", "holanda"];

  List<usersaves> choseselec = [];

  List<Color> colors = [
    Color(0xFF2C2C2C),
    Color(0xFFD9CBEF),
    Color(0xFFD6E9F7),
    Color(0xFFE8D9AE),
    Color(0xFFF4D9D7),
  ];

  @override
  Searchitemsf(String itemname) async {
    isSearching = true;
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.searchitems(itemname);
    print(
      "STATUS: $statusRequest, itemssearches: ${itemssearches.length}, Mostpopular: ${Mostpopular.length}",
    );
    if (response is! Map) {
      statusRequest = StatusRequest.offlinefailure;
      update();
      return;
    }
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;

      update();
      itemssearches.clear();
      itemssearches.addAll(response['alldata']);
      Mostpopular.clear();
      Mostpopular.addAll(response['datapop']);
      cheapestdata.clear();
      cheapestdata.addAll(response['Cheapestdata']);
      latest.clear();
      latest.addAll(response['datalate']);

      String itemid5 = (response['alldata'][0]['items_id'].toString());
      historySearchitemsf(itemname, itemname, itemid5);
    } else {
      if (response["status"] == 'failure') {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
    update();
  }

  @override
  @override
  changeTab1(int index) {
    currentTab = index;
    update();
  }

  @override
  clearhistory() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.clearhistory(
      myServices.sharedPreferences.getString('id')!,
    );
    print(response);
    if (response is! Map) {
      statusRequest = StatusRequest.offlinefailure;
      update();
      return;
    }
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      update();
    } else {
      statusRequest = StatusRequest.failure;
      update();
    }
    update();
  }

  @override
  deleteidistory(item) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.deleteitemhistorry(
      myServices.sharedPreferences.getString('id')!,
      item,
    );
    print(response);
    if (response is! Map) {
      statusRequest = StatusRequest.offlinefailure;
      update();
      return;
    }
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      update();
    } else {
      statusRequest = StatusRequest.failure;

      update();
    }
    update();
  }

  @override
  getpopularsearchf() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.popularsearchnofilter();
    print("POPULAR RESPONSE: $response");
    if (response is! Map) {
      statusRequest = StatusRequest.offlinefailure;
      update();
      return;
    }
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      update();
      mostpopularnofilter.clear();
      mostpopularnofilter.addAll(response['data']);
    } else {
      statusRequest = StatusRequest.failure;
      update();
    }
    update();
  }

  @override
  historySearchitemsf(itemnameE, itemnameAR, itemid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.historysearch(
      itemnameE,
      itemnameAR,
      myServices.sharedPreferences.getString('id')!,
      itemid,
    );
    print(response);
    if (response is! Map) {
      statusRequest = StatusRequest.offlinefailure;
      update();
      return;
    }
    if (response["status"] == "successupdate" ||
        response["status"] == "successinsert") {
      statusRequest = StatusRequest.success;
      update();
    } else {
      statusRequest = StatusRequest.failure;

      update();
    }
    update();
  }

  @override
  getsearchf() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.getsearch(
      myServices.sharedPreferences.getString('id')!,
    );
    print("$response History search ");
    if (response is! Map) {
      statusRequest = StatusRequest.offlinefailure;
      update();
      return;
    }
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      update();
      historysearch.clear();
      List history = response['data'];
      historysearch.addAll(history.map((e) => Searchhistory.fromJson(e)));
    } else {
      statusRequest = StatusRequest.failure;

      update();
    }
    update();
  }

  Color getTagColor(String? tag) {
    switch (tag) {
      case 'Hot':
        return Color(0xFFFFE4E4);
      case 'New':
        return Color(0xFFFFE9D6);
      case 'Popular':
        return Color(0xFFDFF5E3);
      default:
        return Colors.transparent;
    }
  }

  Color getTagTextColor(String? tag) {
    switch (tag) {
      case 'Hot':
        return Colors.red;
      case 'New':
        return Colors.orange;
      case 'Popular':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  String Formatsearchcount(dynamic count) {
    int number = int.tryParse(count.toString()) ?? 0;
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      double re = number / 1000;
      if (re == re.roundToDouble()) {
        return '${re.toInt()}k';
      }
      double round = double.parse(re.toStringAsExponential(1));
      if (round >= 1000) {
        return '${(number / 1000000).toStringAsFixed(1)}M';
      }

      return '${re.toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }

  saveUserChoicesf() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.saveUserChoices();
    print("usercoise $response");
    if (response is! Map) {
      statusRequest = StatusRequest.offlinefailure;
      update();
      return;
    }
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      update();
      choseselec.clear();
      List saves = response['data'];
      choseselec.addAll(saves.map((e) => usersaves.fromJson(e)));
    } else {
      statusRequest = StatusRequest.failure;
      update();
    }
    update();
  }

  Color viewcolor(dynamic type) {
    if (type == "Baby Blue".toLowerCase() ||
        type == "أزرق فاتح".toLowerCase()) {
      return Color(0xFFD6E9F7);
    } else if (type == "Beige".toLowerCase() || type == "بيج".toLowerCase()) {
      return Color(0xFFE8D9AE);
    } else if (type == "Dark Gray".toLowerCase() ||
        type == "رمادي غامق".toLowerCase()) {
      return Color(0xFF2C2C2C);
    } else if (type == 'Blush Pink'.toLowerCase() ||
        type == "وردي فاتح".toLowerCase()) {
      return Color(0xFFF4D9D7);
    } else if (type == 'Lavender'.toLowerCase() ||
        type == "بنفسجي فاتح".toLowerCase()) {
      return Color(0xFFD9CBEF);
    } else {
      return Color(0xFF2C2C2C);
    }
  }

  FilterByF(
    String color,
    String location,
    String itemminprice,
    String itemmaxprice,
    String itemname,
  ) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await data.Filterby(
      color,
      location,
      itemminprice,
      itemmaxprice,
      itemname,
    );
    print(response);
    if (response is! Map) {
      statusRequest = StatusRequest.offlinefailure;
      update();
      return;
    }
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      update();

      cheapestdata.clear();
      cheapestdata.addAll(response['Cheapestdata']);
      latest.clear();
      latest.addAll(response['datalate']);
      itemssearches.clear();
      itemssearches.addAll(response['alldata']);
      Get.back();

      Get.snackbar(
        "Filter",
        "No products match your selected filters.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.newBadge,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
    } else {
      if (response["status"] == 'failure') {
        statusRequest = StatusRequest.failure;
        Get.snackbar(
          "Filter",
          "No products match your selected filters.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFE53935),
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
          borderRadius: 12,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.error_outline, color: Colors.white),
        );
      }
      update();
    }
    update();
  }

  @override
  FormatFilterhcount(count) {
    int number = int.tryParse(count.toString()) ?? 0;
    if (number <= 80) {
      int re = number;

      if (re == re.roundToDouble()) {
        return re.toStringAsFixed(0);
      }
    } else {
      return number.toString();
    }
    return number.toInt();
  }
}
