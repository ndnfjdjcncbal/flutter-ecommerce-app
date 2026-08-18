import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/Map/mapcontroller.dart';

class mappage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MapController controller1 = Get.put(MapController());
    return Scaffold(
      body: GetBuilder<MapController>(
        builder: (builder1) {
          print(
            "BUILD: position=${builder1.position}, kGooglePlex1=${builder1.kGooglePlex1}",
          );
          return Column(
            children: [
              if (builder1.position != null)
                Expanded(
                  child: GoogleMap(
                    key: ValueKey(builder1.kGooglePlex1.toString()),
                    onTap: (LatLng pos) {
                      controller1.selectLocation(pos);
                    },
                    markers: builder1.markers,
                    mapType: MapType.normal,
                    initialCameraPosition: builder1.kGooglePlex1!,
                    onMapCreated: (GoogleMapController controller) {
                      if (!builder1.controllermpa.isCompleted) {
                        print(
                          "BUILD: position=${builder1.position}, kGooglePlex1=${builder1.kGooglePlex1}",
                        );

                        builder1.controllermpa.complete(controller);
                      }
                    },
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                  ),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: controller1.position != null
              ? SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller1.kGooglePlex1 != null) {
                        controller1.Goaddaddrese();
                      }
                    },
                    child: const Text(
                      "إضافة العنوان",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
