import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myservice extends GetxService {
  final SharedPreferences sharedPreferences;

  Myservice({required this.sharedPreferences});
}