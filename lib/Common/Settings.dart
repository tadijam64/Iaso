import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iaso/Views/Family.dart';

class Settings {
  static final Settings _instance = new Settings._internal();

  SharedPreferences prefs;

  factory Settings() {
    _instance.init();
    return _instance;
  }

  Widget startUp() {
    return Family();
  }

  Settings._internal();

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
