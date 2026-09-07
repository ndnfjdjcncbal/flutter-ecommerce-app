import 'package:ecommerce/core/middleware/mymiddleware.dart';
import 'package:ecommerce/view/Notifications/Notidication.dart';
import 'package:ecommerce/view/auth/SignUp.dart';
import 'package:ecommerce/view/auth/login.dart';
import 'package:ecommerce/view/auth/verifiedcode.dart';
import 'package:ecommerce/view/auth/verifiedcodelog.dart';
import 'package:ecommerce/view/onboarding/onboarding.dart';
import 'package:ecommerce/view/profile/edit_profile_page.dart';
import 'package:ecommerce/view/HomeScreen/CategoryWidget.dart';
import 'package:ecommerce/view/HomeScreen/HomeWidget.dart';
import 'package:ecommerce/view/addres/addrespage.dart';
import 'package:ecommerce/view/addres/addrespage2.dart';
import 'package:ecommerce/view/bottom_navigation/favorite.dart';
import 'package:ecommerce/view/bottom_navigation/homepages.dart';
import 'package:ecommerce/view/bottom_navigation/myorder.dart';
import 'package:ecommerce/view/bottom_navigation/profile.dart';
import 'package:ecommerce/view/cart/Cart.dart';
import 'package:ecommerce/view/checkout/checkout.dart';
import 'package:ecommerce/view/getitems_forCategory/getitems_forCategory.dart';
import 'package:ecommerce/view/Language/language.dart';
import 'package:ecommerce/view/productdetails/ProductDetails1.dart';
import 'package:ecommerce/view/settings/settings_page.dart';
import 'package:ecommerce/view/widget/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => Language1(), middlewares: [MyMiddleWare()]),
  GetPage(name: "/onboarding", page: () => onboarding()),
  GetPage(name: "/Login", page: () => Login()),
  GetPage(name: "/SignUp", page: () => SignUp()),
  GetPage(name: "/Verfiedcode", page: () => Verfiedcode()),
  GetPage(name: "/HomePage", page: () => HomePage()),
  GetPage(name: "/Verfiedcodelogin", page: () => Verfiedcodelogin()),
  GetPage(name: "/HomeWidget", page: () => Homewidget()),
  GetPage(name: "/CategoryWidget", page: () => CategoryWidget()),
  GetPage(name: "/Favorite", page: () => Favorite()),
  GetPage(name: "/myorder", page: () => Myorder()),
  GetPage(name: "/myprofile", page: () => myprofile()),

  GetPage(
    name: "/ProductDetails",
    page: () => ProductDetailsPage(),
    transition: Transition.rightToLeftWithFade,
    transitionDuration: const Duration(milliseconds: 350),
    curve: Curves.easeOutCubic,
  ),

  GetPage(name: "/CartPage", page: () => CartPage()),
  // GetPage(name: "/", page: () => CheckoutPage()),
  // GetPage(name: "/", page: () => TestView()),
  GetPage(name: "/mappage", page: () => mappage()),
  GetPage(name: "/AddressPage", page: () => AddressPage()),
  GetPage(name: "/AddressPage2", page: () => AddressPage2()),
  GetPage(name: "/PaymentPage", page: () => PaymentPage()),
  GetPage(name: "/getitems_forCategory", page: () => GetitemsForCategory()),
  GetPage(name: "/Notifications", page: () => Notifications()),
  GetPage(name: "/SettingsPage", page: () => SettingsPage()),
  GetPage(
    name: "/editProfile",
    page: () => EditProfilePage(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
    curve: Curves.easeOutCubic,
  ),
];
