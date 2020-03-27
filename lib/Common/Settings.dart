import 'package:flutter/material.dart';
import 'package:iaso/Views/LoginPhoneNumber.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static final Settings _instance = new Settings._internal();

  SharedPreferences prefs;
  String userId;

  factory Settings() {
    _instance.init();
    return _instance;
  }

  Widget startUp() {
    return LoginPhoneNumber();
  }

  Settings._internal();

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
