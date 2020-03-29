import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Views/Contacts.dart';
import 'package:iaso/Views/Daily.dart';
import 'package:iaso/Views/LoginPhoneNumber.dart';
import 'package:iaso/Views/Pool.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static final Settings _instance = new Settings._internal();

  SharedPreferences prefs;

  String userId;
  bool inited = false, hasUserAddedContacts = false;

  void setUserId(String id) {
    userId = id;
    prefs.setString("userId", id);
  }

  void setHasUserAddedContacts(bool value) {
    hasUserAddedContacts = value;
    prefs.setBool("hasUserAddedContacts", value);
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
    hasUserAddedContacts = prefs.getBool("hasUserAddedContacts");

    if (userId != null) {
      _checkUserData().then((value) {
        if (value) {
          Get.off(Pool());
        } else {
          if (hasUserAddedContacts == null || !hasUserAddedContacts) {
            Get.off(Contacts());
          } else {
            Get.off(Daily());
          }
        }
      });
    } else {
      Get.off(LoginPhoneNumber());
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
