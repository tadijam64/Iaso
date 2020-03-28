import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';

import 'Supply.dart';

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

  Stream<Map<String, HealthCheck>> getAllSupplies() {
    return firestore
        .collection('users')
        .document(Settings().userId)
        .collection("health")
        .snapshots()
        .map((queryResult) {
      return new Map.fromIterable(queryResult.documents,
          key: (item) => item.documentID,
          value: (item) => HealthCheck.fromJson(item.data));
    });
  }

  updateHealthCheck(String healthCheckID, HealthCheck healthCheck) async {
    await firestore
        .collection('users/${Settings().userId}/health')
        .document(healthCheckID)
        .updateData(healthCheck.toJson());
  }
}
