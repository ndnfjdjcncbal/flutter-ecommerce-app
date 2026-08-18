import 'package:ecommerce/core/classes/paymentRequest.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/servises/Mysevice.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class Payment0000 extends GetxController {
  Myservice myservice = Get.find<Myservice>();
  @override
  Future<void> creatpayment(int amount, String currency) async {
    try {
      String secretkey = await stripeIntegeration(
        (amount * 100).toString(),
        currency,
        myservice.sharedPreferences.getString('id')!,
      );
      print(
        "Data,$amount,$currency,${myservice.sharedPreferences.getString('id')!}",
      );
      await _Inilzationpayment(secretkey);
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      Exception(e);
    }
  }

  static Future<void> _Inilzationpayment(String ClientSecre) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: ClientSecre,
        merchantDisplayName: "Ibrahim Store",
      ),
    );
  }

  StatusRequest statusRequest = StatusRequest.none;

  Future<dynamic> pay(
    String currency,
    String paymentMethodId,
    int amount,
  ) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await getclient_secret_onpayfaster(
        currency.toString(),
        paymentMethodId.toString(),
        (amount * 100).toString(),
        myservice.sharedPreferences.getString('id')!.toString(),
      );
      print(response.toString());
      print(
        "Data,$amount,$currency,${myservice.sharedPreferences.getString('id')!}",
      );
      if (response['status'] == 'success') {
        statusRequest = StatusRequest.success;
        Get.showSnackbar(GetSnackBar(title: "Success", message: "pay is done"));
        print(
          "Data,$amount,$currency,${myservice.sharedPreferences.getString('id')!}",
        );
        update();
      } else {
        statusRequest = StatusRequest.exeption;
        update();

        Get.showSnackbar(
          GetSnackBar(title: "Failed", message: "Payment failed"),
        );
      }
    } catch (e) {
      statusRequest = StatusRequest.exeption;
      print("Payment error: $e");
      Get.showSnackbar(GetSnackBar(title: "Error", message: e.toString()));
    }
    update();
  }
}
