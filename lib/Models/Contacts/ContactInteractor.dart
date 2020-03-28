import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Contacts/FirebaseContact.dart';
import 'package:iaso/Models/User/GetUserInteractor.dart';
import 'package:iaso/Models/User/User.dart';

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

    GetUserInteractor intt = new GetUserInteractor();
    User user = await intt.getUserById(Settings().userId);

    Firestore.instance
        .collection('users')
        .where("phoneNumber", isEqualTo: contact.phoneNumber)
        .snapshots()
        .listen((data) async {
      if (data.documents.length > 0) {
        print(contact.phoneNumber);
        Firestore.instance
            .collection('users/' + data.documents[0].documentID + "/requests")
            .document(user.phoneNumber)
            .setData(contact.toJson());
      }
    });
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

  Stream<List<FirebaseContact>> getMyRequests() {
    return firestore
        .collection('users/' + Settings().userId + "/requests")
        .snapshots()
        .map((queryResult) {
      return queryResult.documents.map((DocumentSnapshot user) {
        return FirebaseContact.fromJson(user.data);
      }).toList();
    });
  }

  void approveRequest(String phoneNumber) async {
    GetUserInteractor intt = new GetUserInteractor();
    User user = await intt.getUserById(Settings().userId);

    Firestore.instance
        .collection('users')
        .where("phoneNumber", isEqualTo: phoneNumber)
        .snapshots()
        .listen((data) async {
      if (data.documents.length > 0) {
        Firestore.instance
            .collection('users/' + data.documents[0].documentID + "/contacts")
            .document(user.phoneNumber)
            .updateData({"accepted": true});

        firestore
            .collection('users/${Settings().userId}/requests')
            .document(phoneNumber)
            .delete();
      }
    });
  }

  Stream<List<FirebaseContact>> getContacts(bool showAccepted) {
    return getAllContacts().map((contactList) {
      contactList.removeWhere((item) => item.accepted != showAccepted);
      return contactList;
    });
  }
}
