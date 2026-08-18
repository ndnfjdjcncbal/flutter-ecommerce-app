import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:ecommerce/view/widget/paymentmithod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Cart/Cart_controlle.dart';
import '../../../controller/CheckOut/viewproductandaddrse_controller.dart';
import '../../../controller/Payment integeration/payment_controller.dart';
import '../../../core/counstant/colore.dart';
import '../../../linkapi.dart';
import '../staticmapapi.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    ViewproductandaddrseController co = Get.put(
      ViewproductandaddrseController(),
      permanent: false,
    );
    Payment0000 paymentcontroller = Get.put(Payment0000(), permanent: false);
    Cartcontrollerump controller = Get.find<Cartcontrollerump>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () {
            Get.back();
            controller.viewcart();
          },
        ),
      ),
      body: Container(
        child: GetBuilder<ViewproductandaddrseController>(
          builder: (controllerbuilder) => Handlingdataview(
            statusRequest: controllerbuilder.statusRequest,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final result = await Get.toNamed(approute.addressPage);

                        if (result != null) {
                          co.changeAddress(result.toString());
                          print("Result = $result");
                        }
                        print("Result = $result");
                      },
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
                        child: AddressMapCard(),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controllerbuilder.City.toString(),

                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controllerbuilder.Street.toString(),

                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  "Products",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: GridView.builder(
                    itemCount: controllerbuilder.productselected.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 5,
                      crossAxisCount: 1,
                    ),
                    itemBuilder: (context, index) => Padding(
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
                                "${Linkapi.rimages}"
                                "/${controllerbuilder.productselected[index].itemsImage!}",
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controllerbuilder
                                      .productselected[index]
                                      .itemsName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controllerbuilder
                                      .productselected[index]
                                      .itemsColor!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "\$${controllerbuilder.productselected[index].itemsPrice!}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                const Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black87,
                        ),
                        child: InkWell(
                          onTap: () => showModalBottomSheet(
                            context: Get.context!,
                            builder: (context) => Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text("Payment Method"),
                                  SizedBox(height: 10),
                                  GetBuilder<ViewproductandaddrseController>(
                                    builder: (controllerbuilde1) => Expanded(
                                      child: ListView.builder(
                                        itemCount: controllerbuilde1
                                            .seenFingerprints
                                            .length,
                                        itemBuilder: (context, index) {
                                          return PaymentMethodSheet(
                                            image: controllerbuilde1.formatimage(
                                              "${controllerbuilde1.seenFingerprints.toList()[index].brand}",
                                            ),

                                            onTap: () {
                                              controllerbuilde1.selectPayment(
                                                index,
                                              );
                                            },
                                            subTitle:
                                                "***********${controllerbuilde1.seenFingerprints.toList()[index].last4}",

                                            title:
                                                "${controllerbuilde1.seenFingerprints.toList()[index].brand}",
                                            value:
                                                controllerbuilde1
                                                        .selectedIndex ==
                                                    index
                                                ? true
                                                : false,
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  Handlingdataview(
                                    statusRequest:
                                        controllerbuilder.statusRequest,
                                    widget: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          AppColors.primary,
                                        ),
                                      ),
                                      onPressed: () {
                                        controllerbuilder.seenFingerprints
                                                .toList()
                                                .isNotEmpty
                                            ? paymentcontroller.pay(
                                                'usd',
                                                controllerbuilder
                                                    .seenFingerprints
                                                    .toList()[controllerbuilder
                                                        .selectedIndex]
                                                    .id!
                                                    .toString(),

                                                controllerbuilder.totalPrice
                                                    .toInt(),
                                              )
                                            : paymentcontroller.creatpayment(
                                                controllerbuilder.totalPrice
                                                    .toInt(),
                                                'usd',
                                              );
                                      },

                                      child: const Text(
                                        "Coniform payment",
                                        style: TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Master Card",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "**** **** **** 1234",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total amount",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      controllerbuilder.totalPrice.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.primary,
                      ),
                    ),
                    onPressed: () {
                      controllerbuilder.addOrder(
                        orderType: '0',
                        paymentMethod: '1',
                      );
                    },

                    child: const Text(
                      "Check Now",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
