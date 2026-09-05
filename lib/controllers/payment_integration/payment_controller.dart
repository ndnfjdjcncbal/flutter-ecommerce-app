import 'package:ecommerce/core/classes/paymentRequest.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/controllers/CheckOut/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class Payment0000 extends GetxController {
  bool ispaymentdone = false;
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestpayfaster = StatusRequest.none;

  Myservice myservice = Get.find<Myservice>();

  void closePaymentSheetIfNeeded() {
    final context = Get.context;
    if (context == null) {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      return;
    }

    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
      return;
    }

    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }

  Future<void> creatpayment(int amount, String currency) async {
    if (statusRequest == StatusRequest.loading) return;

    final controller = Get.find<ViewproductandaddrseController>();
    final validationMessage = controller.validateCheckoutSelection(this);
    if (validationMessage != null) {
      Get.snackbar(
        'Required',
        validationMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    statusRequest = StatusRequest.loading;
    update();
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
      ispaymentdone = true;
      statusRequest = StatusRequest.success;

      closePaymentSheetIfNeeded();

      Get.showSnackbar(
        GetSnackBar(
          title: "Payment confirmed",
          message: "Please tap the Checkout button to complete your order.",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      statusRequest = StatusRequest.failure;
      print("Payment Error: $e");
    }
    update();
  }

  static Future<void> _Inilzationpayment(String ClientSecre) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: ClientSecre,
        merchantDisplayName: "Ibrahim Store",
      ),
    );
  }

  pay(String currency, String paymentMethodId, int amount) async {
    ispaymentdone = false;
    update();
    if (statusRequestpayfaster == StatusRequest.loading) return;

    statusRequestpayfaster = StatusRequest.loading;
    update();
    try {
      var response = await getclient_secret_onpayfaster(
        currency.toString(),
        paymentMethodId.toString(),
        (amount * 100).toString(),
        myservice.sharedPreferences.getString('id')!.toString(),
      );
      print(response.toString());
      if (response['status'] == 'success') {
        statusRequestpayfaster = StatusRequest.success;
        ispaymentdone = true;

        closePaymentSheetIfNeeded();

        Get.showSnackbar(
          GetSnackBar(
            title: "Payment confirmed",
            message: "Please tap the Checkout button to complete your order.",
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        if (response['status'] == 'faliure' &&
            response['message'] ==
                'Could not connect to Stripe (https://api.stripe.com/v1/payment_intents)') {
          Get.showSnackbar(
            GetSnackBar(
              title: "Failed",
              message: "Please check your internet connection and try again.",
            ),
          );
        }
      }
    } catch (e) {
      statusRequestpayfaster = StatusRequest.failure;
      print("Payment error: $e");
      Get.showSnackbar(GetSnackBar(title: "Error", message: e.toString()));
    }
    update();
  }
}
