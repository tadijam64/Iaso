import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iaso/Views/Pool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iaso/Views/Family.dart';

class Settings {
  static final Settings _instance = new Settings._internal();

  SharedPreferences prefs;
  String userId = "Z41UXoPcJ4wRDIcLE1CK";

  factory Settings() {
    _instance.init();
    return _instance;
  }

  Widget startUp() {
    return Pool();
  }

  Settings._internal();

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
