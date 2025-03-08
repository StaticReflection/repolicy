import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// App
import 'package:repolicy/app/app.dart';
import 'package:repolicy/app/app_bindings.dart';
import 'package:repolicy/app/constants/app.dart';
import 'package:repolicy/app/translation/languages.dart';
// Services
import 'package:repolicy/app/services/platform_tools/service.dart';
import 'package:repolicy/app/services/app_config/service.dart';
import 'package:repolicy/app/services/log/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  doWhenWindowReady(() {
    appWindow.title = AppConstants.appName;
    appWindow.size = AppConstants.appWindowInitialSize;
    appWindow.minSize = AppConstants.appWindowMinSize;
    appWindow.alignment = AppConstants.appWindowAlignment;
    appWindow.show();
  });

  await GetStorage.init();
  await Get.putAsync(() => LogService().init());
  await Get.putAsync(() => AppConfigService().init());
  await Get.putAsync(() => PlatformToolsService().init());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  void _localLogWriter(String message, {bool isError = false}) {
    const String tag = 'GetX';

    if (isError) {
      Get.find<LogService>().debug(tag, message);
    } else {
      Get.find<LogService>().error(tag, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      logWriterCallback: _localLogWriter,
      // Theme
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      // Localization
      translations: Languages(),
      locale: Get.locale,
      fallbackLocale: Locale('en', 'US'),
      // Routes
      initialBinding: AppBindings(),
      home: FocusScope(
        canRequestFocus: false,
        child: MyApp(),
      ), // Disable app focus
    );
  }
}
