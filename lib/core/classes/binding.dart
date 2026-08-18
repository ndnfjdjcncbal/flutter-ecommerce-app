import 'package:get/get.dart';

import '../localization/changelocal.dart';
import 'crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(crud());

    Get.put(Changelocal(), permanent: true);
  }
}
