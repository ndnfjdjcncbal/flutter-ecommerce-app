import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../controller/Search/Search_controller.dart';
import '../../data/model/Search/popularsearch.dart';
import '../../linkapi.dart';

class popularsearch1 extends StatelessWidget {
  const popularsearch1({super.key});

  @override
  Widget build(BuildContext context) {
    SearchControllerimp homeController0 = Get.find<SearchControllerimp>();

    return Expanded(
      child: GridView.builder(
        itemCount: homeController0.mostpopularnofilter.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.7,
        ),
        itemBuilder: (context, index) {
          popularsearch currentItem1 = popularsearch.fromJson(
            homeController0.mostpopularnofilter[index],
          );
          return Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 107,
                    width: 107,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(17),
                      child: Image.network(
                        "${Linkapi.rimages}"
                        "/${currentItem1.itemsImage!}",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),

                  SizedBox(width: 2.10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(currentItem1.itemsName!),
                        Text(
                          "${homeController0.Formatsearchcount(currentItem1.totalsearch)} search today ",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 30),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: homeController0.getTagColor(currentItem1.tag),
                    ),
                    width: 70,
                    height: 28,
                    alignment: Alignment.center,
                    child: Text(
                      currentItem1.tag!,
                      style: TextStyle(
                        color: homeController0.getTagTextColor(
                          currentItem1.tag,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
