import 'dart:ui';
import 'package:repolicy/app/services/app_config/service.dart';
import 'package:repolicy/app/services/log/service.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  late AppConfigService appConfigService;
  static const String _tag = 'SettingsController';
  late LogService _logService;

  late Rx<Locale> currentLocale;
  late RxBool isDarkMode;

  SettingsController() {
    appConfigService = Get.find<AppConfigService>();
    _logService = Get.find<LogService>();

    currentLocale = appConfigService.language.obs;
    isDarkMode = appConfigService.isDarkMode.obs;
  }

  void changeLanguage(Locale? locale) {
    if (locale != null) {
      _logService.debug(_tag, 'Changing language to ${locale.toLanguageTag()}');
      appConfigService.setLanguage(locale);
      currentLocale.value = locale;
    } else {
      _logService.warning(_tag, 'Language is null');
    }
  }

  void changeThemeMode(bool value) {
    _logService.debug(
      _tag,
      'Changing theme mode to ${appConfigService.themeMode}',
    );
    appConfigService.toggleDarkMode();
    isDarkMode.value = value;
  }
}
