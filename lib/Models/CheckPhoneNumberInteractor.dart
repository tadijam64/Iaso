import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';

class CheckPhoneNumberInteractor {
  checkPhoneNumber(String phoneNumber) {
    Firestore.instance
        .collection('users')
        .where("brojTelefona", isEqualTo: phoneNumber)
        .snapshots()
        .listen((data) async {
      if (data.documents.length > 0) {
        Settings().userId = data.documents[0].documentID;
      } else {
        await Firestore.instance
            .collection('users')
            .add({'brojTelefona': phoneNumber}).then((result) {
          Settings().userId = result.documentID;
        });
      }
    });
  }
}
