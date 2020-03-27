import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static final Settings _instance = new Settings._internal();

  SharedPreferences prefs;

  factory Settings() {
    _instance.init();
    return _instance;
  }

  Settings._internal();

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
