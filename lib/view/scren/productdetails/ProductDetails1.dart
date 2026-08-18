import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ProductDetails/ProductDetails1controller.dart';
import '../../../linkapi.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductDetailsControllerImp controller = Get.put(
      ProductDetailsControllerImp(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            top: 20,
            bottom: 150,
            child: Image.network(
              "${Linkapi.rimages}/${controller.model.itemsImage}",
              fit: BoxFit.fitHeight,
              width: 5,
            ),
          ),

          Column(
            children: [
              SizedBox(height: 380),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  margin: EdgeInsets.only(top: 19),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(37),
                      topRight: Radius.circular(37),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 26),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.model.itemsName!,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),

                          GetBuilder<ProductDetailsControllerImp>(
                            builder: (controllerup) => Handlingdataview(
                              statusRequest: controllerup.statusRequest,
                              widget: Container(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                child: Text(
                                  controllerup.colorItems.isEmpty
                                      ? "0"
                                      : controllerup.countcolor.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Align(
                          alignment: AlignmentGeometry.centerRight,
                          child: Text(
                            "Available in stock",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Color",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      GetBuilder<ProductDetailsControllerImp>(
                        builder: (controllerr) {
                          if (controllerr.colorItems.isEmpty) {
                            return SizedBox.shrink();
                          }

                          return Row(
                            children: List.generate(
                              controllerr.colorItems.length,
                              (index) {
                                final colorItem = controllerr.colorItems[index];

                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () => controllerr.selectColor(
                                      int.parse(colorItem.itemscolorId!),
                                    ),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controllerr.viewcolor(
                                          colorItem.namecolorEn,
                                        ),
                                        border:
                                            controllerr.selectedColor ==
                                                int.parse(
                                                  colorItem.itemscolorId!,
                                                )
                                            ? Border.all(
                                                color: Colors.white,
                                                width: 2,
                                              )
                                            : null,
                                        boxShadow:
                                            controllerr.selectedColor ==
                                                int.parse(
                                                  colorItem.itemscolorId!,
                                                )
                                            ? [
                                                BoxShadow(
                                                  color: controllerr
                                                      .viewcolor(
                                                        colorItem.namecolorEn,
                                                      )
                                                      .withOpacity(0.5),
                                                  blurRadius: 6,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                            : null,
                                      ),
                                      child:
                                          controllerr.selectedColor ==
                                              int.parse(colorItem.itemscolorId!)
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 16,
                                            )
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      GetBuilder<ProductDetailsControllerImp>(
                        builder: (controllerup) {
                          return RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(text: controllerup.model.itemsDesc),
                              ],
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${controller.model.itemsPrice}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              controller.increaseQuantity(
                                controller.model.itemsId!,
                                controller.model.itemscolorId!,
                              );
                              Get.toNamed(approute.cart);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF5B4FE9),
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            label: Text(
                              "Add to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: 20,
            right: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                SizedBox(width: 40),
                Text("Details Product", textAlign: TextAlign.center),
                SizedBox(width: 50),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.favorite_border),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
