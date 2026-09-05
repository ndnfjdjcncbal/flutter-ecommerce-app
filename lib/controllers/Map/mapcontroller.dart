import 'dart:async';

import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../view/approute.dart';

class MapController extends GetxController {
  final Geocoding geocoding = Geocoding();
  final Completer<GoogleMapController> controllermpa =
      Completer<GoogleMapController>();

  StatusRequest statusRequest = StatusRequest.none;

  bool isloadin = false;
  bool istrue = false;
  bool locationServiceDisabled = false;
  bool locationPermissionDeniedForever = false;

  CameraPosition? kGooglePlex1;
  Position? position;
  LatLng? selectedLocation;

  Set<Marker> markers = {};
  String address = '';

  @override
  void onInit() {
    goToTheLake();
    super.onInit();
  }

  void setLoadingState(bool state) {
    isloadin = state;
    update();
  }

  void Goaddaddrese() {
    if (selectedLocation == null) {
      return;
    }

    Get.toNamed(
      approute.addressPage2,
      arguments: {
        "lat": selectedLocation!.latitude,
        "lon": selectedLocation!.longitude,
      },
    );
  }

  Future<void> selectLocation(LatLng position) async {
    selectedLocation = position;
    markers.clear();
    markers.add(
      Marker(markerId: const MarkerId('selected'), position: selectedLocation!),
    );

    final placemarks = await geocoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      address = '${place.street}, ${place.locality}, ${place.country}';
    }

    final controller = await controllermpa.future;
    await controller.animateCamera(CameraUpdate.newLatLng(selectedLocation!));

    update();
  }

  Future<void> goToTheLake() async {
    try {
      locationServiceDisabled = false;
      locationPermissionDeniedForever = false;
      statusRequest = StatusRequest.loading;
      update();

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationServiceDisabled = true;
        statusRequest = StatusRequest.failure;
        update();
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          statusRequest = StatusRequest.failure;
          update();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationPermissionDeniedForever = true;
        statusRequest = StatusRequest.failure;
        update();
        return;
      }

      position = await Geolocator.getCurrentPosition().timeout(
        const Duration(seconds: 35),
        onTimeout: () => throw TimeoutException('Location timeout'),
      );

      if (position == null) {
        statusRequest = StatusRequest.failure;
        update();
        return;
      }

      selectedLocation = LatLng(position!.latitude, position!.longitude);
      kGooglePlex1 = CameraPosition(
        bearing: 192.8334901395799,
        target: selectedLocation!,
        zoom: 19.151926040649414,
      );

      try {
        final controller = await controllermpa.future.timeout(
          const Duration(seconds: 15),
        );
        await controller.animateCamera(
          CameraUpdate.newLatLng(kGooglePlex1!.target),
        );
      } catch (_) {}

      statusRequest = StatusRequest.success;
      update();
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print('ERROR in goToTheLake = $e');
    }
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
