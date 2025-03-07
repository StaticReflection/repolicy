import 'package:flutter/material.dart';
import 'package:repolicy/app/pages/home/controller.dart';
import 'package:repolicy/app/pages/home/widgets/device_list.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [Expanded(child: Placeholder()), DeviceListWidget()]);
  }
}
