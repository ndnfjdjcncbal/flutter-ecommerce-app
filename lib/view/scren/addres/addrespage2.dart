import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Addres/Add_Addres_controller.dart';

class AddressPage2 extends StatelessWidget {
  const AddressPage2({super.key});

  @override
  Widget build(BuildContext context) {
    AddaddresControllerImp controller = Get.put(AddaddresControllerImp());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.toNamed(approute.Mappage),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<AddaddresControllerImp>(
          builder: (controllerbuilder) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                const Text(
                  "Add Your Address",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                TextFormField(
                  controller: controller.country,
                  decoration: InputDecoration(
                    labelText: "Country",
                    prefixIcon: const Icon(Icons.public),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: controller.city,
                  decoration: InputDecoration(
                    labelText: "City",
                    prefixIcon: const Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: controller.street,
                  decoration: InputDecoration(
                    labelText: "Street",
                    prefixIcon: const Icon(Icons.signpost),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.AddAddres();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save Address",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
