import 'package:ecommerce/core/constants/them_data/Thems.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Changelocal extends GetxController {
  Locale? local;
  final myservice = Get.find<Myservice>();
  ThemeData appTheme = themeEnglish;

  Changelocalf(String langcode) {
    Locale locale = Locale(
      langcode,
    ); //دا متغير جوه الدالة يعني لما اضغط ع الدالة
    myservice.sharedPreferences.setString("lang", 'langcode');
    appTheme = langcode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    Future<dynamic> getpreimission() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
      }
    }

    String? sharedPrefLang = myservice.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      local = const Locale("ar");
      appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      local = const Locale("en");
      appTheme = themeEnglish;
    } else {
      local = Locale(Get.deviceLocale!.languageCode);
      appTheme = themeEnglish;
    }
    super.onInit();
  }
}
