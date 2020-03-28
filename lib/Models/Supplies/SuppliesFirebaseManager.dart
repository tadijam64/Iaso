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

  Stream<Map<String, Supply>> getAllSupplies(String userID) {
    return firestore
        .collection('users')
        .document(userID)
        .collection("supplies")
        .snapshots()
        .map((queryResult) {
      return new Map.fromIterable(queryResult.documents,
          key: (item) => item.documentID,
          value: (item) => Supply.fromJson(item.data));
    });
  }

  Stream<Map<String, Supply>> getBuyList(String userID) {
    return firestore
        .collection('users')
        .document(userID)
        .collection("supplies")
        .where("status", isEqualTo: 2)
        .snapshots()
        .map((queryResult) {
      return new Map.fromIterable(queryResult.documents,
          key: (item) => item.documentID,
          value: (item) => Supply.fromJson(item.data));
    });
  }

  updateSupply(String supplyID, Supply supply) async {
    await firestore
        .collection('users/${Settings().userId}/supplies')
        .document(supplyID)
        .updateData(supply.toJson());
  }
}
