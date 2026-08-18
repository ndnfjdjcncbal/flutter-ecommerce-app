import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home/homecontroller.dart';
import '../../../core/classes/handlingdataview.dart';
import '../../../core/counstant/colore.dart';
import '../../../data/model/getitems_model/getitems.dart';
import '../../../linkapi.dart';

class Homewidget extends StatelessWidget {
  Homewidget({super.key});

  @override
  Widget build(BuildContext context) {
    homacontrollerimp controller = Get.find<homacontrollerimp>();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: GetBuilder<homacontrollerimp>(
          builder: (cont) => SingleChildScrollView(
            child: Column(
              children: [
                Handlingdataview(
                  statusRequest: cont.statusRequest,
                  widget: SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: PageView.builder(
                      itemCount: cont.information.length,
                      onPageChanged: (index) {
                        cont.changeTab1(index);
                      },
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(18),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  "${Linkapi.rimages}"
                                  "/${cont.information[index]['baner_name']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    controller.text,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(
                      controller.information.length,
                      (index) => Center(
                        child: AnimatedContainer(
                          margin: EdgeInsets.symmetric(horizontal: 2.3),
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                            color: index == controller.currentTab1
                                ? AppColors.primary
                                : AppColors.grey,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          duration: Duration(milliseconds: 200),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26),
                Container(
                  alignment: AlignmentGeometry.bottomLeft,
                  child: Text(
                    "New Arrifals",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(approute.allitem);
                  },
                  child: Container(
                    alignment: AlignmentGeometry.bottomRight,
                    child: Text(
                      "See All",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cont.itemsl.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    itemsmodelall currentItem = itemsmodelall.fromJson(
                      controller.itemsl[index],
                    );
                    return Column(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(80),
                                      ),
                                    ),
                                    child: Image.network(
                                      "${Linkapi.rimages}"
                                      "/${controller.itemsl[index]['items_image']}",
                                      height: 180,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 115,
                                  top: 16,
                                  child: Container(
                                    alignment: AlignmentGeometry.center,
                                    width: 37,
                                    height: 38,
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(80),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  left: 100,
                                  child: MaterialButton(
                                    onPressed: () {
                                      controller.addfav(currentItem.itemsId!);
                                    },
                                    child: Icon(
                                      Icons.favorite_outline_outlined,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          currentItem.itemsName!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${cont.price}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
