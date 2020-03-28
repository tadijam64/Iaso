import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Health/HealthOverview.dart';

import 'HealthCheck.dart';

class HealthFirebaseManager {
  var firestore = Firestore.instance;

  void addHealthEntry(HealthCheck healthCheck) async {
    return await firestore.collection('users/${Settings().userId}/health').add(healthCheck.toJson()).then((healthDocumentID) {
      return healthDocumentID.documentID;
    });
  }

  void removeHealthEntry(String healthCheckID) async {
    await firestore.collection('users/${Settings().userId}/health').document(healthCheckID).delete();
  }

  Stream<Map<String, HealthCheck>> getAllHealthReportEntries(String userID) {
    return firestore.collection('users').document(userID).collection("health").snapshots().map((queryResult) {
      return new Map.fromIterable(queryResult.documents, key: (item) => item.documentID, value: (item) => HealthCheck.fromJson(item.data));
    });
  }

  double getTemperatureAverage(List<double> temperatureMeasurements) {
    return temperatureMeasurements.reduce((a, b) => a + b) / temperatureMeasurements.length;
  }

  double getAverageCoughs(List<double> temperatureMeasurements) {
    return temperatureMeasurements.reduce((a, b) => a + b) / temperatureMeasurements.length;
  }

  HealthOverview getHealthOverview(List<HealthCheck> healthChecks) {
    if (healthChecks == null || healthChecks.isEmpty) {
      return HealthOverview(temperatureAverage: 0.0, temperatureStatus: TemperatureStatus.good, overallBodyHealth: OverallBodyHealth.good);
    }
    double healthScore = 100;
    const double coughScoreMultipier = 1.3;
    const double headacheScoreMultipier = 0.6;
    const double musclePainMultiplier = 0.9;

    var dryCoughScore = healthChecks.where((entry) => entry.cough == 1).length / healthChecks.length * 100 * coughScoreMultipier;
    var productiveCoughScore = healthChecks.where((entry) => entry.cough == 2).length / healthChecks.length * 100 * coughScoreMultipier;
    var headAcheScore = healthChecks.where((entry) => entry.headache).length / healthChecks.length * 100 * headacheScoreMultipier;
    var musclePain = healthChecks.where((entry) => entry.musclePain).length / healthChecks.length * 100 * musclePainMultiplier;

    healthScore -= dryCoughScore;
    healthScore -= productiveCoughScore;
    healthScore -= headAcheScore;
    healthScore -= musclePain;
    List<double> temperatureList = healthChecks.map((healthCheck) => healthCheck.temperature).toList();
    var temperatureAverage = getTemperatureAverage(temperatureList);
    TemperatureStatus temperatureStatus;
    if (temperatureAverage < 37.5 && temperatureAverage >= 36.5) {
      temperatureStatus = TemperatureStatus.good;
    } else if (temperatureAverage > 37.5 && temperatureAverage < 39.0) {
      temperatureStatus = TemperatureStatus.bad;
    }

    OverallBodyHealth bodyHealth;
    if (healthScore < 40 || temperatureStatus == TemperatureStatus.bad) {
      bodyHealth = OverallBodyHealth.bad;
    } else if (healthScore > 40 && healthScore < 80 && temperatureStatus == TemperatureStatus.good) {
      bodyHealth = OverallBodyHealth.ok;
    } else {
      bodyHealth = OverallBodyHealth.good;
    }

    return new HealthOverview(temperatureAverage: temperatureAverage, temperatureStatus: temperatureStatus, overallBodyHealth: bodyHealth);
  }

  updateHealthCheck(String healthCheckID, HealthCheck healthCheck) async {
    await firestore.collection('users/${Settings().userId}/health').document(healthCheckID).updateData(healthCheck.toJson());
  }
}
