import 'dart:io';
import 'package:repolicy/app/constants/app.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class LogService extends GetxService {
  late final Logger _logger;
  late File _logFile;

  Future<LogService> init() async {
    final directory = Directory(AppConstants.logOutputDirectory);
    if (!directory.existsSync()) {
      directory.createSync();
    }
    final date = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
    _logFile = File(path.join(directory.path, '$date.log'));

    _logger = Logger(
      printer: SimplePrinter(printTime: true, colors: false),
      output: MultiOutput([ConsoleOutput(), FileOutput(file: _logFile)]),
    );
    return this;
  }

  void trace(String tag, Object message) {
    _logger.t('$tag: ${message.toString().trim()}');
  }

  void debug(String tag, Object message) {
    _logger.d('$tag: ${message.toString().trim()}');
  }

  void info(String tag, Object message) {
    _logger.i('$tag: ${message.toString().trim()}');
  }

  void warning(String tag, Object message) {
    _logger.w('$tag: ${message.toString().trim()}');
  }

  void error(String tag, Object message, {StackTrace? stackTrace}) {
    _logger.e(
      '$tag: ${message.toString().trim()} ${stackTrace.toString().trim()}',
    );
  }

  void fatal(String tag, Object message) {
    _logger.f('$tag: ${message.toString().trim()}');
  }
}
