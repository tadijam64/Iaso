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

  Future<void> addContactRequest(FirebaseContact contact) async {
    await Firestore.instance
        .collection('users/' + Settings().userId + "/contacts")
        .document(contact.phoneNumber)
        .setData(contact.toJson());
  }

  Stream<List<FirebaseContact>> getAllContacts() {
    return firestore
        .collection('users')
        .document(Settings().userId)
        .collection("contacts")
        .snapshots()
        .map((queryResult) {
      return queryResult.documents.map((DocumentSnapshot contact) {
        return FirebaseContact.fromJson(contact.data);
      }).toList();
    });
  }

  Stream<List<FirebaseContact>> getContacts(bool showAccepted) {
    return getAllContacts().map((contactList) {
      contactList.removeWhere((item) => item.accepted != showAccepted);
      return contactList;
    });
  }
}
