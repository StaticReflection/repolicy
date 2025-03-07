import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;

class AppConstants {
  // App
  static const String appName = 'RePolicy';

  // App window
  static const Size appWindowInitialSize = Size(1280, 720);
  static const Size appWindowMinSize = appWindowInitialSize;
  static const Alignment appWindowAlignment = Alignment.center;

  // Directory where logs are stored
  static String get logOutputDirectory =>
      path.join(File(Platform.resolvedExecutable).parent.path, 'logs');
}
