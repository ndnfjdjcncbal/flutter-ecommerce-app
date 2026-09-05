import 'package:ecommerce/core/services/Mysevice.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final Myservice _myServices = Get.find<Myservice>();

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}

    await _myServices.sharedPreferences.remove('id');
    await _myServices.sharedPreferences.remove('google');
    await _myServices.sharedPreferences.setString('Step', '2');

    Get.offAllNamed(approute.login);
  }
}
