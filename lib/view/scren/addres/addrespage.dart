import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Addres/addres_controller.dart';
import '../../../data/model/addres/addres.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    AddressControllerImp controller = Get.put(AddressControllerImp());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        ),
        title: const Text(
          "Address",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Choose your location",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 13),

            const Text(
              "Let's find your unforgettable event. Choose a\nlocation below to get started.",
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.6),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_sharp),
                  SizedBox(width: 10),
                  Text(
                    "San Diago, CA",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 30),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(approute.Mappage);
                    },
                    icon: Icon(Icons.my_location_rounded),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Select Location",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 10),
            GetBuilder<AddressControllerImp>(
              builder: (controllerbuilder) => Expanded(
                child: Handlingdataview(
                  statusRequest: controllerbuilder.statusRequest,
                  widget: GridView.builder(
                    itemCount: controllerbuilder.addresview.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      addresmodel address = addresmodel.fromJson(
                        controllerbuilder.addresview[index].toJson(),
                      );
                      return InkWell(
                        onTap: () {
                          controllerbuilder.selectAddress(index);
                          controllerbuilder.gettoviewaddresandpayment(
                            controllerbuilder.addresview[index].addresId!,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: controller.selectedAddress == index
                                  ? AppColors.primary
                                  : AppColors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${address.addresCity}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),

                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${address.addresStreet}",
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
