import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Cart/Cart_controlle.dart';
import '../../../core/classes/handlingdataview.dart';
import '../../widget/Widgetcart/cart_item.dart';
import '../../widget/Widgetcart/promocode.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Cartcontrollerump controller = Get.put(Cartcontrollerump());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                SizedBox(width: 100),
                Text("My Cart", textAlign: TextAlign.center),
                SizedBox(width: 70),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.favorite_border),
                ),
              ],
            ),
            GetBuilder<Cartcontrollerump>(
              builder: (controllerbuild) => Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3.2,
                  ),
                  itemCount: controllerbuild.cartlist.length,
                  itemBuilder: (context, index) {
                    return Handlingdataview(
                      statusRequest: controllerbuild.statusRequest,
                      widget: CartItem(
                        model: controllerbuild.cartlist[index],
                        isSelected: controllerbuild.selectedItems[index],
                        onChanged: (value) {
                          controller.toggleItem(index, value!);
                        },
                        onAdd: () {
                          controllerbuild.increaseQuantity(
                            controllerbuild.cartlist[index].itemsId!,
                            controllerbuild.cartlist[index].cartColor!,
                          );
                        },
                        onRemove: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
            GetBuilder<Cartcontrollerump>(
              builder: (builder) => Handlingdataview(
                statusRequest: builder.statusRequest,
                widget: CartSummarySection(
                  promoController: builder.cupon,
                  subtotal:
                      builder.cartlist.isNotEmpty &&
                          builder.index1 < builder.cartlist.length &&
                          builder.selectedItems[builder.index1] == true
                      ? builder.getSelectedSubtotal()
                      : 0,

                  shipping: builder.shipping,
                  total:
                      builder.cartlist.isNotEmpty &&
                          builder.index1 < builder.cartlist.length &&
                          builder.selectedItems[builder.index1] == true
                      ? builder.getSelectedSubtotalwithshiping()
                      : 0,
                  onApplyPromo: () {
                    builder.cupondiscount(builder.id);
                  },
                  onCheckout: () {
                    builder.getSelectedCartItems();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
