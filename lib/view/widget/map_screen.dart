import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/Map/mapcontroller.dart';

class mappage extends StatelessWidget {
  mappage({super.key});

  static const LatLng defaultLocation = LatLng(26.8206, 30.8025);
  static const CameraPosition defaultCameraPosition = CameraPosition(
    target: defaultLocation,
    zoom: 14.0,
  );

  final MapController controller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: GetBuilder<MapController>(
        builder: (mapController) {
          final cameraPosition =
              mapController.kGooglePlex1 ?? defaultCameraPosition;
          final locationIssue =
              mapController.locationServiceDisabled ||
              mapController.locationPermissionDeniedForever;

          return Handlingdataview(
            statusRequest: locationIssue
                ? StatusRequest.none
                : mapController.statusRequest,
            widget1: _buildLoadingState(),
            widget: locationIssue
                ? _buildLocationIssue(mapController)
                : _buildMapBody(mapController, cameraPosition),
            onRetry: mapController.goToTheLake,
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: GetBuilder<MapController>(
            builder: (mapController) {
              if (mapController.position == null) {
                return const SizedBox.shrink();
              }

              return _buildActionButton(mapController);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Skeletonizer(
      enabled: true,
      child: Container(
        color: const Color(0xFFEAEAEA),
        child: const Center(
          child: Icon(
            Icons.map_outlined,
            size: 80,
            color: Color.fromARGB(255, 129, 128, 128),
          ),
        ),
      ),
    );
  }

  Widget _buildMapBody(
    MapController controller,
    CameraPosition initialCameraPosition,
  ) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: GoogleMap(
              onTap: (LatLng pos) => controller.selectLocation(pos),
              markers: controller.markers,
              mapType: MapType.hybrid,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController mapController) {
                if (!controller.controllermpa.isCompleted) {
                  controller.controllermpa.complete(mapController);
                }
              },
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationIssue(MapController controller) {
    final serviceDisabled = controller.locationServiceDisabled;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Icon(
                serviceDisabled
                    ? Icons.location_off_outlined
                    : Icons.location_disabled_outlined,
                color: const Color(0xFF2563EB),
                size: 42,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              serviceDisabled ? 'خدمة الموقع مغلقة' : 'صلاحية الموقع غير مفعلة',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1D1D1D),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              serviceDisabled
                  ? 'فعّل الموقع من إعدادات الهاتف لاستخدام الخريطة.'
                  : 'اسمح للتطبيق باستخدام الموقع من إعدادات التطبيق.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: serviceDisabled
                    ? controller.openLocationSettings
                    : controller.openAppSettings,
                icon: const Icon(Icons.settings_outlined),
                label: Text(
                  serviceDisabled
                      ? 'فتح إعدادات الموقع'
                      : 'فتح إعدادات التطبيق',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D1D1D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: controller.goToTheLake,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(MapController controller) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (controller.kGooglePlex1 != null) {
            controller.Goaddaddrese();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D1D1D),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        child: const Text('إضافة العنوان'),
      ),
    );
  }
}
