import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Supplies/Supply.dart';

class SuppliesFirebaseManager {
  var firestore = Firestore.instance;

  void addSupply(Supply supply) async {
    return await firestore
        .collection('users/${Settings().userId}/supplies')
        .add(supply.toJson())
        .then((supplyDocumentRef) {
      return supplyDocumentRef.documentID;
    });
  }

  void removeSupply(String supplyID) async {
    await firestore
        .collection('users/${Settings().userId}/supplies')
        .document(supplyID)
        .delete();
  }

  Stream<List<Supply>> getAllSupplies(String userID) {
    return firestore
        .collection('users')
        .document(userID)
        .collection("supplies")
        .snapshots()
        .map((queryResult) {
      return queryResult.documents.map((f) {
        return Supply.fromJson(f.documentID, f.data);
      }).toList();
    });
  }

  Stream<List<Supply>> getBuyList(String userID) {
    return firestore
        .collection('users')
        .document(userID)
        .collection("supplies")
        .where("status", isGreaterThan: 0)
        .snapshots()
        .map((queryResult) {
      return queryResult.documents.map((f) {
        return Supply.fromJson(f.documentID, f.data);
      }).toList();
    });
  }

  Stream<List<Supply>> getBoughtList(String userID) {
    return firestore
        .collection('users')
        .document(userID)
        .collection("supplies")
        .where("status", isGreaterThan: 1)
        .snapshots()
        .map((queryResult) {
      return queryResult.documents.map((f) {
        return Supply.fromJson(f.documentID, f.data);
      }).toList();
    });
  }

  updateSupply(String supplyID, Supply supply) async {
    await firestore
        .collection('users/${Settings().userId}/supplies')
        .document(supplyID)
        .updateData(supply.toJson());
  }
}
