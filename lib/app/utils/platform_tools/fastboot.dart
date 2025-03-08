import 'dart:io';

import 'package:repolicy/app/enum/power_action.dart';
import 'package:repolicy/app/exception/platform_tools.dart';
import 'package:repolicy/app/models/device_info.dart';
import 'package:repolicy/app/models/device_list.dart';
import 'package:repolicy/app/services/log/service.dart';
import 'package:get/get.dart';

class Fastboot {
  static const String _tag = 'PlatformToolsUtilFastboot';
  static late final LogService _logService;

  static late final String _fastbootPath;

  Future<Fastboot> init() async {
    _logService = Get.find<LogService>();
    _logService.info(_tag, 'Initializing');

    await Process.run('where', ['fastboot']).then((result) {
      if (result.stderr != '') {
        _logService.error(
          _tag,
          'Initializing fastboot failed: ${result.stderr}',
          stackTrace: StackTrace.current,
        );
        throw PlatformToolsException(
          PlatformToolsExceptionType.platformToolsNotFound,
          result.stderr.trim(),
        );
      } else {
        _fastbootPath = result.stdout.trim();
        _logService.info(_tag, 'Fastboot path: $_fastbootPath');
      }
    });

    return this;
  }

  Future<String> execute(List<String> arguments) async {
    return await Process.run(_fastbootPath, arguments).then((result) {
      if (result.exitCode != 0) {
        throw Exception(result.stderr);
      }
      return result.stdout;
    });
  }

  Future<DeviceList> getDeviceList() async {
    return await execute(['devices']).then((result) {
      final devices = result.trim().split('\n');
      final deviceList = <DeviceInfo>[];

      _logService.trace(_tag, 'fastboot devices:\n$result');

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
      execute(['-s', serial, 'oem', 'shutdown']);
    } else {
      execute(['-s', serial, 'reboot', action.mode]);
    }
  }
}
