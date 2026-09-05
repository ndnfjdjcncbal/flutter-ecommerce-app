import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../../view/approute.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    Myservice myServices = Get.find();

    String? step = myServices.sharedPreferences.getString("Step");

    if (route == approute.language) {
      return null;
    }

    if (step == "1") {
      return const RouteSettings(name: approute.homepage0);
    } else if (step == '2') {
      return const RouteSettings(name: approute.login);
    } else {
      return const RouteSettings(name: approute.language);
    }
  }
}
