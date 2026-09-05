import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/view/widget/custom_dropdown_button.dart';
import 'package:ecommerce/view/widget/paymentmithod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/Cart/Cart_controlle.dart';
import '../../controllers/CheckOut/checkout_controller.dart';
import '../../controllers/payment_integration/payment_controller.dart';
import '../../core/classes/statusrequest.dart';
import '../../core/constants/colore.dart';
import '../../linkapi.dart';
import '../staticmapapi.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewproductandaddrseController());
    final paymentController = Get.put(Payment0000());
    final cartController = Get.find<Cartcontrollerump>();
    Myservice myServices = Get.find();

    return Scaffold(
      appBar: _buildAppBar(cartController, controller),
      body: GetBuilder<ViewproductandaddrseController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget1: const _CheckoutSkeleton(),
          onBack: () => Get.back(),
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AddressSection(controller: controller),
                const SizedBox(height: 24),
                const Text(
                  "Products",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _ProductsList(controller: controller),
                const SizedBox(height: 12),
                _PaymentMethodPreview(
                  controller: controller,
                  paymentController: paymentController,
                ),
                const SizedBox(height: 24),
                _TotalAmountSection(totalPrice: controller.totalPrice),
                const SizedBox(height: 20),
                _CheckoutButton(
                  controller: controller,
                  paymentController: paymentController,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(
    Cartcontrollerump cartController,
    ViewproductandaddrseController c,
  ) {
    return AppBar(
      title: Text("60".tr),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 18),
        onPressed: () async {
          Get.back(result: c.selected);

          cartController.viewcart();
        },
      ),
    );
  }
}

class _AddressSection extends StatelessWidget {
  final ViewproductandaddrseController controller;

  const _AddressSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () => controller.goToAddressPage(),
              child: Text(
                "Edit",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.backgroundGrey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 110,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.backgroundGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AddressMapCard(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.City,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.Street,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductsList extends StatelessWidget {
  final ViewproductandaddrseController controller;

  const _ProductsList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.productselected.length,
        itemBuilder: (context, index) {
          final product = controller.productselected[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 55,
                    height: 55,
                    color: AppColors.backgroundGrey.withOpacity(0.2),
                    child: Image.network(
                      "${Linkapi.rimages}/${product.itemsImage!}",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.itemsName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.itemsColor!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${product.itemsPrice!}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PaymentMethodPreview extends StatelessWidget {
  final ViewproductandaddrseController controller;
  final Payment0000 paymentController;

  const _PaymentMethodPreview({
    required this.controller,
    required this.paymentController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "61".tr,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => _showPaymentBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.credit_card, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Select Payment Method",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _PaymentBottomSheet(
        controller: controller,
        paymentController: paymentController,
      ),
    );
  }
}

class _PaymentBottomSheet extends StatelessWidget {
  final ViewproductandaddrseController controller;
  final Payment0000 paymentController;

  const _PaymentBottomSheet({
    required this.controller,
    required this.paymentController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownButton(
                    hintText: "Order Type",
                    items: controller.orderTypes,
                    valueListenable: controller.orderTypeSelected,
                    onChanged: controller.updateOrderType,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomDropdownButton(
                    hintText: "Payment Type",
                    items: controller.paymentTypes,
                    valueListenable: controller.paymentTypeSelected,
                    onChanged: controller.updatePaymentType,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GetBuilder<ViewproductandaddrseController>(
              builder: (ctrl) {
                final cards = ctrl.seenFingerprints.toList();
                return Handlingdataview(
                  statusRequest: ctrl.statusRequestlatestnumber,
                  onRetry: () => ctrl.getlatestnumber(),
                  widget: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        return PaymentMethodSheet(
                          image: ctrl.formatimage("${card.brand}"),
                          onTap: () {
                            ctrl.selectPayment(index);
                          },
                          subTitle: "************${card.last4}",
                          title: "${card.brand}",
                          value: ctrl.selectedIndex == index,
                        );
                      },
                    ),
                  ),
                  widget1: Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (_, index) => PaymentMethodSheet(
                        image: "assets/visa.png",
                        onTap: () {},
                        subTitle: "**** **** **** 0000",
                        title: "Visa Card",
                        value: false,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  paymentController.creatpayment(
                    controller.totalPrice.toInt(),
                    'usd',
                  );
                },
                icon: const Icon(Icons.add_circle_outline, size: 20),
                label: const Text(
                  'Add Payment Method',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            _ConfirmPaymentButton(
              controller: controller,
              paymentController: paymentController,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmPaymentButton extends StatelessWidget {
  final ViewproductandaddrseController controller;
  final Payment0000 paymentController;

  const _ConfirmPaymentButton({
    required this.controller,
    required this.paymentController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GetBuilder<Payment0000>(
        builder: (payCtrl) {
          if (payCtrl.statusRequestpayfaster == StatusRequest.success) {
            Future.delayed(Duration.zero, () {
              Get.snackbar(
                'Payment confirmed',
                'Your payment method was selected successfully.',
                snackPosition: SnackPosition.TOP,
                backgroundColor: AppColors.primary,
                colorText: const Color.fromARGB(255, 238, 241, 239),
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                margin: const EdgeInsets.only(top: 50, left: 16, right: 16),
                borderRadius: 12,
                duration: const Duration(seconds: 2),
              );
            });
          }
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: AppColors.primary,
            ),
            onPressed: payCtrl.statusRequestpayfaster == StatusRequest.loading
                ? () {}
                : () {
                    final validationMessage = controller
                        .validateCheckoutSelection(paymentController);

                    if (validationMessage != null) {
                      Get.snackbar(
                        'Required',
                        validationMessage,
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppColors.primary,
                        colorText: AppColors.white,
                        margin: const EdgeInsets.only(
                          top: 50,
                          left: 16,
                          right: 16,
                        ),
                        borderRadius: 12,
                      );
                      return;
                    }

                    final cards = controller.seenFingerprints.toList();
                    if (controller.selectedIndex < 0 ||
                        controller.selectedIndex >= cards.length) {
                      Get.snackbar(
                        'Select payment method',
                        'Please choose a saved payment method first.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppColors.primary,
                        colorText: AppColors.white,
                        margin: const EdgeInsets.only(
                          top: 50,
                          left: 16,
                          right: 16,
                        ),
                        borderRadius: 12,
                      );
                      return;
                    }

                    paymentController.pay(
                      'usd',
                      cards[controller.selectedIndex].id!,
                      controller.totalPrice.toInt(),
                    );
                  },
            child: payCtrl.statusRequestpayfaster == StatusRequest.loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    "Confirm Payment",
                    style: TextStyle(color: Colors.white),
                  ),
          );
        },
      ),
    );
  }
}

class _TotalAmountSection extends StatelessWidget {
  final double totalPrice;

  const _TotalAmountSection({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Total amount",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          "\$$totalPrice",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _CheckoutButton extends StatelessWidget {
  final ViewproductandaddrseController controller;
  final Payment0000 paymentController;

  const _CheckoutButton({
    required this.controller,
    required this.paymentController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
        onPressed: controller.statusRequestOrder == StatusRequest.loading
            ? null
            : () => controller.onCheckoutPressed(paymentController),
        child: controller.statusRequestOrder == StatusRequest.loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "Check Now",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
}

class _CheckoutSkeleton extends StatelessWidget {
  const _CheckoutSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (_, __) => ListTile(
                leading: const CircleAvatar(),
                title: Container(height: 10, color: Colors.grey[300]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
