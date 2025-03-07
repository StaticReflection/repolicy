import 'package:repolicy/app/enum/device_state.dart';
import 'package:repolicy/app/enum/power_action.dart';
import 'package:repolicy/app/exception/platform_tools.dart';
import 'package:repolicy/app/models/device_info.dart';
import 'package:repolicy/app/models/device_list.dart';
import 'package:repolicy/app/services/log/service.dart';
import 'package:repolicy/app/utils/platform_tools/platform_tools.dart';
import 'package:get/get.dart';
import 'package:repolicy/app/widgets/prompt_dialog.dart';

class PlatformToolsService {
  static const _tag = 'PlatformToolsService';
  late final LogService _logService;

  DeviceInfo? selectedDevice;

  Future<PlatformToolsService> init() async {
    _logService = Get.find<LogService>();
    _logService.info(_tag, 'Initializing');

    await PlatformToolsUtil.init();

    return this;
  }

  void switchDevice(DeviceInfo? device) {
    _logService.debug(_tag, 'Switch device to: $device');
    selectedDevice = device;
  }

  Future<DeviceList> getDeviceList() async {
    final deviceList = await PlatformToolsUtil.getDeviceList();

    if (selectedDevice == null && deviceList.isNotEmpty) {
      switchDevice(deviceList[0]);
    }
    return deviceList;
  }

  Future<void> powerAction(PowerAction action) async {
    _logService.debug(_tag, 'Power action: ${action.name}');

    if (selectedDevice != null) {
      if (selectedDevice?.state
          case DeviceState.device || DeviceState.recovery) {
        PlatformToolsUtil.adb.powerAction(selectedDevice!.serial, action);
      } else if (selectedDevice?.state == DeviceState.fastboot) {
        PlatformToolsUtil.fastboot.powerAction(selectedDevice!.serial, action);
      }
    } else {
      throw PlatformToolsException(
        PlatformToolsExceptionType.noDeviceSelected,
        'No device selected',
      );
    }
  }

  // Wireless connection
  // If pairing code is empty, it will connect to the device without pairing
  Future<void> wirelessConnection(String ip, String? pairingCode) async {
    _logService.debug(_tag, 'ip: $ip, pairingCode: $pairingCode');
    if (pairingCode == null || pairingCode == '') {
      _logService.debug(_tag, 'Pairing code is empty');
      final result = await PlatformToolsUtil.adb.connect(ip);
      Get.dialog(PromptDialog(content: result));
    } else {
      _logService.debug(_tag, 'Pairing code is not empty');
      final result = await PlatformToolsUtil.adb.pair(ip, pairingCode);
      Get.dialog(PromptDialog(content: result));
    }
  }
}
