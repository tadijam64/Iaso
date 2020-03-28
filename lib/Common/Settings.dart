import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Views/Family.dart';
import 'package:iaso/Views/LoginPhoneNumber.dart';
import 'package:iaso/Views/Pool.dart';
import 'package:iaso/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static final Settings _instance = new Settings._internal();

  SharedPreferences prefs;

  String userId;
  bool inited = false;

  void setUserId(String id) {
    userId = id;
    prefs.setString("userId", id);
  }

  factory Settings() {
    _instance.init();
    return _instance;
  }

  Widget startUp() {
    if (!inited) {
      init().then((data) {
        startUp();
      });
      return Material();
    }

    userId = prefs.getString("userId");
    print(userId);
    if (userId != null) {
      _checkUserData().then((value) {
        if (value) {
          Get.to(Pool());
        } else {
          Get.off(Family());
        }
      });
    } else {
      Get.to(LoginPhoneNumber());
    }
  }

  Settings._internal();

  Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    inited = true;
    return true;
  }

  Future<bool> _checkUserData() async {
    DocumentSnapshot ds =
        await Firestore.instance.collection('users').document(userId).get();

    bool error = false;
    if (ds["name"] == null) {
      error = true;
    }

    if (ds["age"] == null) {
      error = true;
    }

    return error;
  }
}
