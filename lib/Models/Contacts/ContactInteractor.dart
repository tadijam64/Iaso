import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Contacts/FirebaseContact.dart';

class ContactInteractor {
  var firestore = Firestore.instance;

  Future<void> saveData(FirebaseContact contact) async {
    await Firestore.instance
        .collection('users/' + Settings().userId + "/contacts")
        .document(contact.phoneNumber)
        .updateData(contact.toJson());
  }

  Stream<List<FirebaseContact>> getAllContactRequests() {
    return firestore
        .collection('users')
        .document(Settings().userId)
        .collection("contacts")
        .where("accepted", isEqualTo: false)
        .snapshots()
        .map((queryResult) {
      return queryResult.documents.map((DocumentSnapshot contact) {
        return FirebaseContact.fromJson(contact.data);
      }).toList();
    });
  }
}
