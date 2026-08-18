import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../view/approute.dart';

class MapController extends GetxController {
  @override
  void onInit() {
    goToTheLake();
    super.onInit();
  }

  bool isloadin = false;
  CameraPosition? kGooglePlex1;
  Position? position;

  final Geocoding geocoding = Geocoding();
  LatLng? selectedLocation;
  Set<Marker> markers = {};
  String address = "";
  bool istrue = false;

  Goaddaddrese() {
    Get.toNamed(
      approute.addressPage2,
      arguments: {
        "lat": selectedLocation!.latitude,
        "lon": selectedLocation!.longitude,
      },
    );
  }

  Future<dynamic> selectLocation(LatLng position) async {
    selectedLocation = position;
    markers.clear();
    markers.add(
      Marker(markerId: const MarkerId("selected"), position: selectedLocation!),
    );

    List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final GoogleMapController controller = await controllermpa.future;
    await controller.animateCamera(CameraUpdate.newLatLng(selectedLocation!));
    Placemark place = placemarks.first;
    address = "${place.street}, ${place.locality},${place.country}";

    print(place.country);
    print(place.street);
    print(place.name);

    update();
  }

  Completer<GoogleMapController> controllermpa =
      Completer<GoogleMapController>();

  Future<dynamic> goToTheLake() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("GPS مقفول");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("المستخدم رفض صلاحية الموقع");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("الصلاحية مرفوضة نهائيًا، لازم تتفتح من الإعدادات");
        return;
      }

      position = await Geolocator.getCurrentPosition();
      print("lat=${position!.latitude} lon=${position!.longitude}");

      kGooglePlex1 = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(position!.latitude, position!.longitude),
        zoom: 19.151926040649414,
      );
      GoogleMapController controller = await controllermpa.future;

      await controller.animateCamera(
        CameraUpdate.newLatLng(kGooglePlex1!.target),
      );
    } catch (e, s) {
      print("ERROR in goToTheLake = $e");
      print(s);
    }
  }
}
