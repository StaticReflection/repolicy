import 'package:flutter/material.dart';

// Pages
import 'package:repolicy/app/pages/settings/page.dart';
import 'package:repolicy/app/pages/home/page.dart';

class Page {
  final String label;
  final IconData icon;
  final Widget page;

  Page({required this.label, required this.icon, required this.page});
}

class AppPages {
  static final pages = [
    Page(icon: Icons.home, label: 'home', page: HomePage()),
    Page(icon: Icons.settings, label: 'settings', page: SettingsPage()),
  ];
}
