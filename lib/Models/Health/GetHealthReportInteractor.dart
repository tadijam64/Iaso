import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Health/HealthOverview.dart';
import 'package:iaso/Models/Reminders/ReminderManager.dart';
import 'package:iaso/Models/User/User.dart';
import 'package:iaso/Views/Daily.dart';
import 'package:iaso/Widget/Chat.dart';

import 'HealthCheck.dart';

class HealthFirebaseManager {
  var firestore = Firestore.instance;

  void addHealthEntry(HealthCheck healthCheck) async {
    await firestore
        .collection('users/${Settings().userId}/health')
        .add(healthCheck.toJson());

    if (healthCheck.temperature > 37.5) {
      /*ReminderManager().showNotification("Health status",
          "Uh oh, your temperature is up, I will remind you to measure it again in 2 hours");*/
      ReminderManager().scheduleNotification(
          "Health status",
          "How about we check your health?",
          DateTime.now().add(Duration(hours: 4)),
          Deeplink.health);
      Get.off(Daily(iasoDefault: <Widget>[
        ChatBubble(
          right: false,
          text:
              "Looks like you have a fever. Try to bring it down and I'll check back with you in few hours :)",
        ),
        SizedBox(
          height: 10,
        )
      ]));
    }
  }

  void removeHealthEntry(String healthCheckID) async {
    await firestore
        .collection('users/${Settings().userId}/health')
        .document(healthCheckID)
        .delete();
  }

  Stream<List<HealthCheck>> getAllHealthReportEntries(String userID) {
    return firestore
        .collection('users')
        .document(userID)
        .collection("health")
        .snapshots()
        .map((queryResult) {
      return queryResult.documents.map((report) {
        return HealthCheck.fromJson(report.documentID, report.data);
      }).toList();
    });
  }

  double getTemperatureAverage(List<double> temperatureMeasurements) {
    return temperatureMeasurements.reduce((a, b) => a + b) /
        temperatureMeasurements.length;
  }

  double getAverageCoughs(List<double> temperatureMeasurements) {
    return temperatureMeasurements.reduce((a, b) => a + b) /
        temperatureMeasurements.length;
  }

  double getUserRiskScore(User user) {
    double riskScore = 0.0;
    riskScore += user.cancer == true ? 1 : 0 * 0.5;
    riskScore += user.age > 60 ? 1 : 0 * 0.5;
    riskScore += user.hypertension == true ? 1 : 0 * 0.5;
    riskScore += user.diabetes == true ? 1 : 0 * 0.5;
    riskScore += user.cardiovascularIssues == true ? 1 : 0 * 0.5;
    riskScore += user.chronicRespiratoryDisease == true ? 1 : 0 * 0.5;
    if (user.lastContactWithInfectedPerson != null) {
      riskScore += user.lastContactWithInfectedPerson
              .isBefore(DateTime.now().subtract(Duration(days: 6)))
          ? 0
          : 1 * 0.5;
    }

    return min(max(riskScore, 0), 1);
  }

  double calculateHealthRiskScore(User user, HealthCheck healthCheck) {
    double temperatureWeights = 1.0;
    double dryCoughWeight = 0.771;
    double productiveCoughWeight = 0.379;
    double fatigueWeight = 0.433;
    double shortnessOfBreathWeight = 0.212;
    double soreThroatWeight = 0.158;
    double headacheWeight = 0.154;
    double musclePainWeight = 0.154;

    double symptomsRiskScore = getUserRiskScore(user);
    symptomsRiskScore +=
        (healthCheck.temperature > 37.5 ? 1 : 0) * temperatureWeights;
    symptomsRiskScore += (healthCheck.cough == 1 ? 1 : 0) * dryCoughWeight;
    symptomsRiskScore +=
        (healthCheck.cough == 2 ? 1 : 0) * productiveCoughWeight;
    symptomsRiskScore += (healthCheck.fatigue == true ? 1 : 0) * fatigueWeight;
    symptomsRiskScore += (healthCheck.shortnessOfBreath == true ? 1 : 0) *
        shortnessOfBreathWeight;
    symptomsRiskScore +=
        (healthCheck.soreThroat == true ? 1 : 0) * soreThroatWeight;
    symptomsRiskScore +=
        (healthCheck.headache == true ? 1 : 0) * headacheWeight;
    symptomsRiskScore +=
        (healthCheck.musclePain == true ? 1 : 0) * musclePainWeight;
    return symptomsRiskScore;
  }

  HealthOverview getHealthOverview(User user, List<HealthCheck> healthChecks) {
    if (healthChecks == null || healthChecks.isEmpty) {
      return HealthOverview(
          healthScore: 0,
          temperatureAverage: 0.0,
          temperatureStatus: TemperatureStatus.good,
          overallBodyHealth: OverallBodyHealth.good);
    }

    healthChecks.sort((item1, item2) {
      if (item1.timestamp.isAfter(item2.timestamp)) {
        return 0;
      } else {
        return 1;
      }
    });

    double healthScoreSum = 0.0;

    for (var i = 0; i < healthChecks.length.clamp(0, 6); i++) {
      healthScoreSum +=
          (calculateHealthRiskScore(user, healthChecks[i])) * (1 / 10 * i);
    }
    // worst per case score 427 (allSymptoms + riskScore)
    double worstTotalScore = 531;
    double totalHealthScore = (healthScoreSum * 100).floor() / worstTotalScore;

    OverallBodyHealth bodyHealth;
    if (totalHealthScore < 0.1) {
      bodyHealth = OverallBodyHealth.excellent;
    } else if (totalHealthScore >= 0.1 && totalHealthScore <= 0.2) {
      bodyHealth = OverallBodyHealth.veryGood;
    } else if (totalHealthScore > 0.2 && totalHealthScore <= 0.4) {
      bodyHealth = OverallBodyHealth.good;
    } else if (totalHealthScore > 0.4 && totalHealthScore <= 0.6) {
      bodyHealth = OverallBodyHealth.ok;
    } else if (totalHealthScore > 0.6 && totalHealthScore <= 0.8) {
      bodyHealth = OverallBodyHealth.bad;
    } else if (totalHealthScore > 0.8 && totalHealthScore <= 1.0) {
      bodyHealth = OverallBodyHealth.veryBad;
    }

    List<double> temperatureList =
        healthChecks.map((healthCheck) => healthCheck.temperature).toList();
    var temperatureAverage = getTemperatureAverage(temperatureList);
    TemperatureStatus temperatureStatus;
    if (temperatureAverage >= 35.8 && temperatureAverage < 37.0) {
      temperatureStatus = TemperatureStatus.good;
    } else if (temperatureAverage > 37.0 && temperatureAverage < 38.0) {
      temperatureStatus = TemperatureStatus.ok;
    } else {
      temperatureStatus = TemperatureStatus.bad;
    }
    return new HealthOverview(
        temperatureAverage: temperatureAverage,
        temperatureStatus: temperatureStatus,
        overallBodyHealth: bodyHealth);
  }

  updateHealthCheck(String healthCheckID, HealthCheck healthCheck) async {
    await firestore
        .collection('users/${Settings().userId}/health')
        .document(healthCheckID)
        .updateData(healthCheck.toJson());
  }
}
