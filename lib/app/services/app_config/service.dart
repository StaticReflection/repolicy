import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:repolicy/app/constants/key.dart';
import 'package:repolicy/app/services/log/service.dart';

class AppConfigService extends GetxService {
  static const String _tag = 'AppConfigService';

  late GetStorage _box;
  late LogService _logService;

  Future<AppConfigService> init() async {
    _box = GetStorage();
    _logService = Get.find<LogService>();

    _logService.info(_tag, 'Initializing');

    //  Set default language
    await _box.writeIfNull(
      AppKey.language,
      Get.deviceLocale?.toLanguageTag() ?? 'en-US',
    );
    Get.updateLocale(language);

    // Set default theme
    await _box.writeIfNull(AppKey.themeMode, ThemeMode.dark.index);
    Get.changeThemeMode(themeMode);

    return this;
  }

  // Get theme mode
  ThemeMode get themeMode {
    if (_box.read(AppKey.themeMode) == null) {
      _logService.info(_tag, 'Theme mode not set, using default');
      return ThemeMode.dark;
    }
    return ThemeMode.values[_box.read(AppKey.themeMode)];
  }

  // is dark mode
  bool get isDarkMode => themeMode == ThemeMode.dark;
  // toggle dark mode
  void toggleDarkMode() {
    _logService.info(_tag, 'Toggle dark mode');
    setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  // Set theme mode
  void setThemeMode(ThemeMode themeMode) {
    if (this.themeMode == themeMode) {
      _logService.warning(_tag, 'Theme mode already set to $themeMode');
      return;
    }
    _logService.info(_tag, 'Set theme mode to $themeMode');
    _box.write(AppKey.themeMode, themeMode.index);
    Get.changeThemeMode(themeMode);
  }

  // Get language
  Locale get language {
    String? localeTag = _box.read<String>(AppKey.language);
    if (localeTag == null) {
      _logService.info(_tag, 'Language not set, using default');
      return const Locale('en', 'US');
    }
    List<String> parts = localeTag.split('-');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }

  // Set language
  void setLanguage(Locale locale) {
    if (language == locale) {
      _logService.warning(
        _tag,
        'Language already set to ${locale.toLanguageTag()}',
      );
      return;
    }
    _logService.info(_tag, 'Set language to ${locale.toLanguageTag()}');
    _box.write(AppKey.language, locale.toLanguageTag());
    Get.updateLocale(locale);
  }
}
