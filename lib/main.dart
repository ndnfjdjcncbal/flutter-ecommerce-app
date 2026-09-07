import 'package:ecommerce/core/constants/app_links/routes.dart';
import 'package:ecommerce/core/constants/app_links/Stripe_Key/payment_keys.dart';
import 'package:ecommerce/core/localization/translation.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/classes/binding.dart';
import 'core/localization/changelocal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPrefs = await SharedPreferences.getInstance();
  Get.put(Myservice(sharedPreferences: sharedPrefs), permanent: true);
  Stripe.publishableKey = Apikeys.Publishablekey;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Changelocal controller = Get.put(Changelocal());

    return GetMaterialApp(
      themeMode: ThemeMode.system,
      locale: controller.local,
      translations: MyTranslation(),
      title: 'Flutter ',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialBinding: InitialBindings(),
      getPages: routes,
    );
  }
}
