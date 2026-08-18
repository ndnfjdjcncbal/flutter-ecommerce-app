import 'package:ecommerce/view/auth/SignUp.dart';
import 'package:ecommerce/view/auth/login.dart';
import 'package:ecommerce/view/auth/verifiedcode.dart';
import 'package:ecommerce/view/auth/verifiedcodelog.dart';
import 'package:ecommerce/view/onboarding/onboarding.dart';
import 'package:ecommerce/view/scren/BottomNavBarHome/favorite.dart';
import 'package:ecommerce/view/scren/BottomNavBarHome/homepages.dart';
import 'package:ecommerce/view/scren/BottomNavBarHome/myorder.dart';
import 'package:ecommerce/view/scren/BottomNavBarHome/profile.dart';
import 'package:ecommerce/view/scren/HomeScreen/CategoryWidget.dart';
import 'package:ecommerce/view/scren/HomeScreen/HomeWidget.dart';
import 'package:ecommerce/view/scren/addres/addrespage.dart';
import 'package:ecommerce/view/scren/addres/addrespage2.dart';
import 'package:ecommerce/view/scren/allitems.dart';
import 'package:ecommerce/view/scren/cart/Cart.dart';
import 'package:ecommerce/view/scren/checkout/viewaddressandproduct.dart';
import 'package:ecommerce/view/scren/language.dart';
import 'package:ecommerce/view/scren/productdetails/ProductDetails1.dart';
import 'package:ecommerce/view/widget/Map.dart';
import 'package:get/get.dart';

import 'core/middleware/mymiddleware.dart';

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
  GetPage(name: "/myorder", page: () => myorder()),
  GetPage(name: "/myprofile", page: () => myprofile()),

  GetPage(name: "/ProductDetails", page: () => ProductDetailsPage()),

  GetPage(name: "/CartPage", page: () => CartPage()),
  // GetPage(name: "/", page: () => CheckoutPage()),
  // GetPage(name: "/", page: () => TestView()),
  GetPage(name: "/mappage", page: () => mappage()),
  GetPage(name: "/AddressPage", page: () => AddressPage()),
  GetPage(name: "/AddressPage2", page: () => AddressPage2()),
  GetPage(name: "/PaymentPage", page: () => PaymentPage()),
  GetPage(name: "/allitems", page: () => allitems()),
];
