import 'dart:convert';
import 'dart:io';

import 'package:repolicy/app/enum/power_action.dart';
import 'package:repolicy/app/exception/platform_tools.dart';
import 'package:repolicy/app/models/device_info.dart';
import 'package:repolicy/app/models/device_list.dart';
import 'package:repolicy/app/services/log/service.dart';
import 'package:get/get.dart';

class Adb {
  static const String _tag = 'PlatformToolsUtilAdb';
  static late final LogService _logService;

  static late final String _adbPath;

  Future<Adb> init() async {
    _logService = Get.find<LogService>();
    _logService.info(_tag, 'Initializing');

    await Process.run('where', ['adb']).then((result) async {
      if (result.stderr != '') {
        _logService.error(
          _tag,
          'Initializing adb failed: ${result.stderr}',
          stackTrace: StackTrace.current,
        );
        throw PlatformToolsException(
          PlatformToolsExceptionType.platformToolsNotFound,
          result.stderr.trim(),
        );
      } else {
        _adbPath = result.stdout.trim();
        _logService.info(_tag, 'ADB path: $_adbPath');
        _logService.debug(_tag, 'starting ADB server');
        await execute(['start-server']);
      }
    });

    return this;
  }

  Future<String> execute(List<String> arguments) async {
    _logService.debug(_tag, 'execute: $_adbPath $arguments');

    final result = await Process.run(
      _adbPath,
      arguments,
      stdoutEncoding: utf8,
      stderrEncoding: utf8,
    );
    if (result.stderr == null || result.stderr == '') {
      return result.stdout;
    } else {
      return result.stderr;
    }
  }

  // Get adb device list
  Future<DeviceList> getDeviceList() async {
    return await execute(['devices']).then((result) {
      final devices = result.trim().split('\n').sublist(1);
      final deviceList = <DeviceInfo>[];

      _logService.trace(_tag, 'adb devices:\n$result');

      for (final device in devices) {
        if (device.isNotEmpty) {
          final deviceInfo = device.split('\t');
          deviceList.add(
            DeviceInfo(
              serial: deviceInfo[0],
              state: DeviceInfo.parseState(deviceInfo[1]),
            ),
          );
        }
      }

      _logService.debug(_tag, 'device list: $deviceList');
      return deviceList;
    });
  }

  Future<void> powerAction(String serial, PowerAction action) async {
    if (action == PowerAction.poweroff) {
      execute(['-s', serial, 'shell', 'reboot', '-p']);
    } else {
      execute(['-s', serial, 'reboot', action.mode]);
    }
  }

  // Wireless connect device
  Future<String> connect(String ip) async {
    _logService.debug(_tag, 'adb connect $ip');
    final result = execute(['connect', ip]);
    _logService.debug(_tag, 'connect result: $result');
    return result;
  }

  // Wireless pair device
  Future<String> pair(String ip, String pairingCode) async {
    _logService.debug(_tag, 'adb pair $ip $pairingCode');
    final result = execute(['pair', ip, pairingCode]);
    _logService.debug(_tag, 'pair result: $result');
    return result;
  }
}
