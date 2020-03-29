import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Health/HealthOverview.dart';
import 'package:iaso/Models/User/User.dart';

import 'HealthCheck.dart';

class HealthFirebaseManager {
  var firestore = Firestore.instance;

  void addHealthEntry(HealthCheck healthCheck) async {
    return await firestore
        .collection('users/${Settings().userId}/health')
        .add(healthCheck.toJson())
        .then((healthDocumentID) {
      return healthDocumentID.documentID;
    });
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
          ? 1
          : 0 * 0.5;
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
        return 1;
      } else {
        return 0;
      }
    });

    double healthScoreSum = 0.0;

    for (var i = 1; i < healthChecks.length + 1; i++) {
      healthScoreSum +=
          (calculateHealthRiskScore(user, healthChecks[i - 1]) / i);
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

    int totalHealthScore =
        ((healthScoreSum / healthChecks.length) * 100).floor();

    OverallBodyHealth bodyHealth;
    if (totalHealthScore <= 105) {
      bodyHealth = OverallBodyHealth.excellent;
    } else if (healthScoreSum > 105 &&
        healthScoreSum < 210 &&
        bodyHealth == OverallBodyHealth.good) {
      bodyHealth = OverallBodyHealth.ok;
    } else if (healthScoreSum > 210 &&
        healthScoreSum < 315 &&
        bodyHealth == OverallBodyHealth.ok) {
      bodyHealth = OverallBodyHealth.ok;
    } else if (healthScoreSum > 315 &&
        healthScoreSum < 420 &&
        bodyHealth == OverallBodyHealth.bad) {
      bodyHealth = OverallBodyHealth.ok;
    } else if (healthScoreSum > 420 &&
        healthScoreSum < 525 &&
        bodyHealth == OverallBodyHealth.veryBad) {
      bodyHealth = OverallBodyHealth.ok;
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
