import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home/homecontroller.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    homacontrollerimp controller = Get.put(homacontrollerimp());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: GetBuilder<homacontrollerimp>(
          builder: (controller) =>
              Handlingdataview(
                statusRequest: controller.statusRequest,
                widget: GridView.builder(
                  itemCount: controller.categoryl.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      Stack(
                        children: [
                          Positioned(
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,

                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                width: double.infinity,
                                child: Image.network(
                                  "${Linkapi.rimages}"
                                      "/${controller
                                      .categoryl[index]['category_image']}",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
