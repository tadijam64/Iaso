import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/Settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoAway-20',
        navigatorKey: Get.key,
        home: Settings().startUp());
  }
}
