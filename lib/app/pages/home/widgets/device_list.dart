import 'package:flutter/material.dart';
import 'package:repolicy/app/enum/power_action.dart';
import 'package:repolicy/app/pages/home/controller.dart';
import 'package:get/get.dart';

class DeviceListWidget extends GetView<HomeController> {
  const DeviceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(4),
            title: Text('device_list'.tr),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton<PowerAction>(
                  tooltip: 'power_action'.tr,
                  icon: Icon(Icons.power_settings_new),
                  onSelected: controller.powerAction,
                  itemBuilder: (BuildContext context) {
                    return PowerAction.values.map((PowerAction action) {
                      return PopupMenuItem<PowerAction>(
                        value: action,
                        child: Text(action.language.tr),
                      );
                    }).toList();
                  },
                ),

                Tooltip(
                  message: 'wireless_connection'.tr,
                  child: IconButton(
                    icon: Icon(Icons.wifi),
                    onPressed: controller.wirelessConnection,
                  ),
                ),
                Tooltip(
                  message: 'refresh'.tr,
                  child: IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: controller.refreshDeviceList,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Card(
              child: Obx(
                () => ListView(
                  shrinkWrap: true,
                  children:
                      controller.deviceList.value
                          .map(
                            (deviceInfo) => RadioListTile(
                              value: deviceInfo,
                              groupValue: controller.selectedDevice.value,
                              onChanged: controller.switchDevice,
                              title: Text(
                                deviceInfo.serial,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(deviceInfo.state.name),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
