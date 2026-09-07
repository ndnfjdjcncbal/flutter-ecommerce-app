import 'dart:convert';

import 'package:ecommerce/core/constants/app_links/linkapi.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

Myservice myservice = Get.find<Myservice>();

Future<String> stripeIntegeration(
  String amount,
  String currency,
  String userid,
) async {
  final response = await http.post(
    Uri.parse(Linkapi.paymentRequest),
    body: {"currency": currency, "amount": amount, "user_id": userid},
  );
  print(response.body);
  final data = jsonDecode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print(response.statusCode);

    print("DATAAAAAAA${data.toString()}");
    try {
      return data['dataclient_secret'].toString();
    } catch (e) {
      return e.toString();
    }
  } else {
    throw Exception(data['error'] ?? 'Payment request failed');
  }
}

getclient_secret_onpayfaster(
  String currency,
  String paymentMethodId,
  String amount,
  String userid,
) async {
  var response = await http.post(
    Uri.parse(Linkapi.payfaster),
    body: {
      "currency": currency,
      "payment_method_id": paymentMethodId,
      "amount": amount,
      "user_id": userid,
    },
  );
  print(response.body);
  var data = jsonDecode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print(response.statusCode);
    return data;
  } else {
    throw Exception(data['error'] ?? 'Payment request failed');
  }
}
