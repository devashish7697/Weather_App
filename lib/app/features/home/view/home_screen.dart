import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/core/global_controller.dart';

import '../controller/home_contoller.dart';

class HomeScreen extends GetView<HomeController> {

  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Weather App'),),
    );
  }}