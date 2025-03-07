import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repolicy/app/services/platform_tools/service.dart';

class WirelessConnectionDialog extends StatelessWidget {
  const WirelessConnectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController ipAddressController = TextEditingController();
    final TextEditingController pairingCodeController = TextEditingController();

    return AlertDialog(
      title: Text('wireless_connection'.tr),
      content: Row(
        spacing: 8,
        children: [
          SizedBox(
            width: 180,
            child: TextField(
              controller: ipAddressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('${'ip_address'.tr}:${'port'.tr}'),
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: TextField(
              controller: pairingCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('${'pairing_code'.tr}(${'optional'.tr})'),
              ),
            ),
          ),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () async {
            Get.find<PlatformToolsService>().wirelessConnection(
              ipAddressController.text,
              pairingCodeController.text,
            );
            Get.back();
          },
          child: Text('connect'.tr),
        ),
        ElevatedButton(onPressed: Get.back, child: Text('cancel'.tr)),
      ],
    );
  }
}
