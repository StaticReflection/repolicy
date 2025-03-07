import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:repolicy/app/widgets/close_app_dialog.dart';
import 'package:get/get.dart';

// Controllers
import 'package:repolicy/app/app_pages.dart';
import 'package:repolicy/app/services/log/service.dart';

class MyAppController extends GetxController {
  static const String _tag = 'MyAppController';
  late LogService _logService;

  final selectedIndex = 0.obs;

  MyAppController() {
    _logService = Get.find<LogService>();
  }

  // change page
  void changePage(int index) {
    if (selectedIndex.value == index) {
      _logService.debug(_tag, 'Page is already selected');
      return;
    }
    _logService.debug(_tag, 'Changing page to $index');
    selectedIndex.value = index;
  }

  // window actions
  void close() {
    _logService.debug(_tag, 'Open close app dialog');
    Get.dialog(CloseAppDialog());
  }

  void maximizeOrRestore() {
    _logService.debug(_tag, 'Toggling window');
    appWindow.maximizeOrRestore();
  }

  void minimize() {
    _logService.debug(_tag, 'Minimizing window');
    appWindow.minimize();
  }
}

class MyApp extends GetView<MyAppController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: MoveWindow(
          child: AppBar(
            title: Text('app_title'.tr),
            actions: [
              IconButton(
                onPressed: controller.minimize,
                icon: Icon(Icons.remove),
              ),
              IconButton(
                onPressed: controller.maximizeOrRestore,
                icon: Icon(Icons.square_outlined),
              ),
              IconButton(onPressed: controller.close, icon: Icon(Icons.close)),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          Obx(
            () => NavigationDrawer(
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: controller.changePage,
              children:
                  AppPages.pages.map((page) {
                    return NavigationDrawerDestination(
                      icon: Icon(page.icon),
                      label: Text(page.label.tr),
                    );
                  }).toList(),
            ),
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedIndex.value,
                children: AppPages.pages.map((page) => page.page).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
