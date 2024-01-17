import 'package:blissful_marry/features/home/data/controllers/home_controller.dart';
import 'package:blissful_marry/features/login/data/controllers/auth_controller.dart';

import 'package:get/instance_manager.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController());
    // Get.put(SeatManagementController());
  }
}
