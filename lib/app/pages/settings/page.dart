import 'package:flutter/material.dart';
import 'package:repolicy/app/pages/settings/controller.dart';
import 'package:repolicy/app/translation/languages.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('language'.tr),
          trailing: Obx(
            () => DropdownButton(
              value: controller.currentLocale.value,
              items:
                  Languages.supportedLocales
                      .map(
                        (locale) => DropdownMenuItem(
                          value: locale,
                          child: Text(locale.toLanguageTag()),
                        ),
                      )
                      .toList(),
              onChanged: (Locale? newLocale) {
                controller.changeLanguage(newLocale);
              },
            ),
          ),
        ),
        Obx(
          () => SwitchListTile(
            title: Text('dark_mode'.tr),
            value: controller.isDarkMode.value,
            onChanged: controller.changeThemeMode,
          ),
        ),
      ],
    );
  }
}
