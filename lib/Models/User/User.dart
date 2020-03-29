import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  int age;
  String name;
  String phoneNumber;
  bool hypertension;
  bool diabetes;
  bool cardiovascularIssues;
  bool chronicRespiratoryDisease;
  bool cancer;
  DateTime lastContactWithInfectedPerson;
  Uint8List avatar;

  User({
    this.id,
    this.age,
    this.name,
    this.hypertension,
    this.cardiovascularIssues,
    this.chronicRespiratoryDisease,
    this.diabetes,
    this.cancer,
    this.phoneNumber,
  });

  User.fromJson(String documentID, Map<String, dynamic> json) {
    id = documentID;
    age = json['age'];
    name = json['name'];
    hypertension = json['hypertension'];
    cardiovascularIssues = json['cardiovascularIssues'];
    chronicRespiratoryDisease = json['chronicRespiratoryDisease'];
    diabetes = json['diabetes'];
    cancer = json['cancer'];
    phoneNumber = json['phoneNumber'];
    lastContactWithInfectedPerson =
        json['lastContactWithInfectedPerson'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                json['lastContactWithInfectedPerson']?.millisecondsSinceEpoch)
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['name'] = this.name;
    data['hypertension'] = this.hypertension;
    data['cardiovascularIssues'] = this.cardiovascularIssues;
    data['chronicRespiratoryDisease'] = this.chronicRespiratoryDisease;
    data['cancer'] = this.cancer;
    data['diabetes'] = this.diabetes;
    data['phoneNumber'] = this.phoneNumber;
    data['lastContactWithInfectedPerson'] =
        this.lastContactWithInfectedPerson != null
            ? Timestamp.fromDate(this.lastContactWithInfectedPerson)
            : null;
    return data;
  }
}
