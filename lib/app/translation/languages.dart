import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Languages extends Translations {
  static const supportedLocales = [Locale('zh', 'CN'), Locale('en', 'US')];

  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      'app_title': 'RePolicy',
      'home': '首页',
      'settings': '设置',
      'language': '语言',
      'dark_mode': '暗色模式',
      'log': '日志',
      'device_list': '设备列表',
      'prompt': '提示',
      'are_you_sure_you_want_to_exit': '确定要退出吗？',
      'yes': '是',
      'no': '否',
      'confirm': '确认',
      'cancel': '取消',
      'power_action': '电源操作',
      'power_off': '关机',
      'reboot': '重启',
      'reboot_to_fastboot': '重启到 Fastboot',
      'reboot_to_recovery': '重启到 Recovery',
      'reboot_to_fastbootd': '重启到 FastbootD',
      'refresh': '刷新',
      'wireless_connection': '无线连接',
      'connect': '连接',
      'ip_address': 'IP地址',
      'pairing_code': '配对码',
      'optional': '可选',
      'port': '端口',
    },
    'en_US': {
      'app_title': 'RePolicy',
      'home': 'Home',
      'settings': 'Settings',
      'language': 'Language',
      'dark_mode': 'Dark Mode',
      'log': 'Log',
      'device_list': 'Device List',
      'prompt': 'Prompt',
      'are_you_sure_you_want_to_exit': 'Are you sure you want to exit?',
      'yes': 'Yes',
      'no': 'No',
      'confirm': 'Confirm',
      'cancel': 'Cancel',
      'power_action': 'Power Action',
      'power_off': 'Power Off',
      'reboot': 'Reboot',
      'reboot_to_fastboot': 'Reboot to Fastboot',
      'reboot_to_recovery': 'Reboot to Recovery',
      'reboot_to_fastbootd': 'Reboot to FastbootD',
      'refresh': 'Refresh',
      'wireless_connection': 'Wireless Connection',
      'connect': 'Connect',
      'ip_address': 'IP Address',
      'pairing_code': 'Pairing code',
      'optional': 'Optional',
      'port': 'Port',
    },
  };
}
