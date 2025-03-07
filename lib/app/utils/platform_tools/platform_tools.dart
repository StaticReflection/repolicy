import 'package:repolicy/app/models/device_list.dart';
import 'package:repolicy/app/services/log/service.dart';
import 'package:repolicy/app/utils/platform_tools/adb.dart';
import 'package:repolicy/app/utils/platform_tools/fastboot.dart';
import 'package:get/get.dart';

class PlatformToolsUtil {
  static const String _tag = 'PlatformToolsUtil';
  static late final LogService _logService;

  static late final Adb adb;
  static late final Fastboot fastboot;

  static Future<void> init() async {
    _logService = Get.find<LogService>();
    _logService.info(_tag, 'Initializing');

    adb = await Adb().init();
    fastboot = await Fastboot().init();

    getDeviceList();
  }

  static Future<DeviceList> getDeviceList() async {
    final adbDevices = await adb.getDeviceList();
    final fastbootDevices = await fastboot.getDeviceList();

    // Combine the list of ADB and Fastboot devices
    final DeviceList deviceList = [...adbDevices, ...fastbootDevices];
    _logService.info(_tag, 'Device list: $deviceList');
    return deviceList;
  }
}
