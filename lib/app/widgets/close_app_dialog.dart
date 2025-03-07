import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CloseAppDialog extends StatelessWidget {
  const CloseAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('prompt'.tr),
      content: Text('are_you_sure_you_want_to_exit'.tr),
      actions: <Widget>[
        FilledButton(onPressed: appWindow.close, child: Text('confirm'.tr)),
        ElevatedButton(onPressed: Get.back, child: Text('cancel'.tr)),
      ],
    );
  }
}
