import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';

class CheckPhoneNumberInteractor {
  bool checkPhoneNumber(String phoneNumber) {
    Firestore.instance
        .collection('users')
        .where("brojTelefona", isEqualTo: phoneNumber)
        .snapshots()
        .listen((data) {
      if (data.documents.length > 0) {
        Settings().userId = data.documents[0].documentID;
        return true;
      } else {
        // todo add new user, set ID and return true
        Firestore.instance
            .collection('users')
            .document()
            .setData({'brojTelefona': phoneNumber});
        return checkPhoneNumber(phoneNumber);
      }
    });
  }
}
