import 'package:repolicy/app/app.dart';
import 'package:get/get.dart';

// Controllers
import 'package:repolicy/app/pages/home/controller.dart';
import 'package:repolicy/app/pages/settings/controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAppController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SettingsController());
  }
}
