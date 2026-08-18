import 'package:ecommerce/view/approute.dart';
import 'package:ecommerce/view/widget/widgetpopularsearch.dart';
import 'package:ecommerce/view/widget/widgetseacrh.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controller/Search/Search_controller.dart';
import '../../core/counstant/colore.dart';
import 'materialbutton.dart';

class SearchPage extends StatelessWidget {
  SearchControllerimp homeController0 = Get.put(SearchControllerimp());

  void onSearchSubmit(String query) {
    if (query.trim().isEmpty) return;
    homeController0.Searchitemsf(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<SearchControllerimp>(
          builder: (controller) => Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 11),

              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () {
                      Get.offAllNamed(approute.homepage0);
                    },
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => onSearchSubmit(
                              homeController0.searchController.text,
                            ),
                            child: Container(
                              width: 34,
                              height: 34,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Icon(
                                Icons.search_outlined,
                                color: Colors.grey.shade700,
                                size: 30,
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: TextField(
                              controller: homeController0.searchController,
                              focusNode: homeController0.focusNode,
                              textInputAction: TextInputAction.search,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onSubmitted: onSearchSubmit,
                            ),
                          ),

                          if (controller.isSearching)
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: AppColors.white,
                                  context: Get.context!,
                                  builder: (context) {
                                    return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(5),
                                      child: GetBuilder<SearchControllerimp>(
                                        builder: (controllerfilter) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(height: 8),
                                            Center(child: Text("Filter By")),

                                            SizedBox(height: 24),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Price"),
                                                Text(
                                                  "${controllerfilter.values.start.toInt()} -\$80",
                                                  style: TextStyle(
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 0),
                                            SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(
                                                    activeTrackColor:
                                                        AppColors.primary,
                                                    inactiveTrackColor:
                                                        AppColors
                                                            .backgroundGrey,
                                                    trackHeight: 2,
                                                    rangeThumbShape:
                                                        BorderedRangeThumbShape(
                                                          thumbRadius: 8,
                                                          borderWidth: 3.5,
                                                          borderColor:
                                                              AppColors.primary,
                                                          fillColor:
                                                              Colors.white,
                                                        ),
                                                    overlayShape:
                                                        const RoundSliderOverlayShape(
                                                          overlayRadius: 5,
                                                        ),
                                                    valueIndicatorStrokeColor:
                                                        AppColors.white,
                                                    valueIndicatorColor:
                                                        AppColors.primary,
                                                  ),
                                              child: RangeSlider(
                                                values: controllerfilter.values,
                                                min: 0,
                                                max: 80,
                                                onChanged: (newValues) {
                                                  controllerfilter.updatevalues(
                                                    newValues,
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 20),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("color"),
                                                Text(
                                                  controllerfilter
                                                      .colorname[controllerfilter
                                                      .isselected],

                                                  style: TextStyle(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ...List.generate(
                                                  controllerfilter
                                                      .choseselec
                                                      .length,
                                                  (int index) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            right: 31.3,
                                                          ),

                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        color: controllerfilter
                                                            .viewcolor(
                                                              controllerfilter
                                                                  .choseselec[index]
                                                                  .itemsColor!,
                                                            ),
                                                        shape: BoxShape.circle,
                                                      ),

                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        splashFactory: NoSplash
                                                            .splashFactory,
                                                        canRequestFocus: false,
                                                        autofocus: false,
                                                        enableFeedback: true,
                                                        onTap: () {
                                                          controllerfilter
                                                              .chnageselect(
                                                                index,
                                                              );
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              width: 25,
                                                              height: 25,
                                                              decoration: BoxDecoration(
                                                                color: controllerfilter
                                                                    .colors[index],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),

                                                            controllerfilter
                                                                        .isselected ==
                                                                    index
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 16,
                                                                    weight:
                                                                        50.5,
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 28),

                                            Text("Location"),
                                            SizedBox(height: 14),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ...List.generate(
                                                  controllerfilter
                                                          .choseselec
                                                          .length -
                                                      2,
                                                  (index) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashFactory:
                                                        NoSplash.splashFactory,
                                                    onTap: () {
                                                      controllerfilter
                                                          .chnagelocation(
                                                            index,
                                                          );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 5,
                                                          ),
                                                      height: 50,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              13,
                                                            ),
                                                        color:
                                                            controllerfilter
                                                                    .locationselected ==
                                                                index
                                                            ? AppColors.primary
                                                            : AppColors
                                                                  .backgroundGrey,
                                                      ),
                                                      child: Text(
                                                        controllerfilter
                                                            .choseselec[index]
                                                            .itemsLocation!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              controllerfilter
                                                                      .locationselected ==
                                                                  index
                                                              ? AppColors.white
                                                              : AppColors
                                                                    .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 32),

                                            Materialbutton(
                                              text: 'APPLY Filter',
                                              onPressed: () {
                                                controllerfilter.FilterByF(
                                                  controllerfilter
                                                      .choseselec[controllerfilter
                                                          .isselected]
                                                      .itemsColor!,
                                                  controllerfilter
                                                      .choseselec[controllerfilter
                                                          .locationselected]
                                                      .itemsLocation!,
                                                  controllerfilter.values.start
                                                      .toString(),
                                                  controllerfilter.values.end
                                                      .toString(),
                                                  controllerfilter
                                                      .searchController
                                                      .text,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.tune),
                              color: Colors.grey.shade700,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (controller.isSearching) ...[
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController0.filters.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        homeController0.changeFilter(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: const EdgeInsets.only(right: 9),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey, width: 0.5),
                          color: homeController0.selectedFilter == index
                              ? AppColors.primary
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          homeController0.filters[index],
                          style: TextStyle(
                            color: homeController0.selectedFilter == index
                                ? AppColors.white
                                : AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                homeController0.pagessearch[homeController0.selectedFilter],
              ] else
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Search",
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              controller.clearhistory();
                            },
                            child: Text(
                              "Clear All",
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: controller.historysearch.map((e) {
                          return GestureDetector(
                            onTap: () {
                              homeController0.searchController.text =
                                  e.historysearchName ?? '';
                              onSearchSubmit(e.historysearchName ?? '');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    e.historysearchName ?? '',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () {
                                      controller.deleteidistory(
                                        e.historysearchId!,
                                      );
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        "Popular Search",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      popularsearch1(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
