import 'package:repolicy/app/enum/power_action.dart';
import 'package:repolicy/app/models/device_info.dart';
import 'package:repolicy/app/models/device_list.dart';
import 'package:repolicy/app/services/log/service.dart';
import 'package:repolicy/app/services/platform_tools/service.dart';
import 'package:get/get.dart';
import 'package:repolicy/app/widgets/wireless_connection_dialog.dart';

class HomeController extends GetxController {
  static const String _tag = 'HomeController';
  late final LogService _logService;
  late final PlatformToolsService _platformToolsService;

  Rx<DeviceList> deviceList = Rx<DeviceList>([]);
  Rxn<DeviceInfo> selectedDevice = Rxn<DeviceInfo>(null);

  HomeController() {
    _logService = Get.find<LogService>();
    _platformToolsService = Get.find<PlatformToolsService>();

    refreshDeviceList();
  }

  void refreshDeviceList() async {
    _logService.debug(_tag, 'Refresh device list');
    deviceList.value = await _platformToolsService.getDeviceList();
    selectedDevice.value = _platformToolsService.selectedDevice;
  }

  void switchDevice(DeviceInfo? device) {
    _logService.debug(_tag, 'Switch device to: $device');
    _platformToolsService.switchDevice(device);
    selectedDevice.value = _platformToolsService.selectedDevice;
  }

  void powerAction(PowerAction action) {
    _logService.debug(_tag, 'Power action: ${action.name}');
    _platformToolsService.powerAction(action);
  }

  void wirelessConnection() {
    Get.dialog(WirelessConnectionDialog());
  }
}
