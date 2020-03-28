import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';

class CheckPhoneNumberInteractor {
  checkPhoneNumber(String phoneNumber) {
    Firestore.instance
        .collection('users')
        .where("phoneNumber", isEqualTo: phoneNumber)
        .snapshots()
        .listen((data) async {
      if (data.documents.length > 0) {
        print("Nisam dodao");
        Settings().setUserId(data.documents[0].documentID);
        Settings().startUp();
      } else {
        await Firestore.instance
            .collection('users')
            .add({'phoneNumber': phoneNumber}).then((result) {
          Settings().setUserId(result.documentID);
          Settings().startUp();
        });
      }
    });
  }
}
