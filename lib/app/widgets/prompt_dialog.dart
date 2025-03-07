import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromptDialog extends StatelessWidget {
  final String content;

  const PromptDialog({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('prompt'.tr),
      content: Text(content),
      actions: [ElevatedButton(onPressed: Get.back, child: Text('confirm'.tr))],
    );
  }
}
