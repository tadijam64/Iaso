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

        Settings().setUserId(data.documents[0].documentID);
        //TODO: popraviti kada se što događa tako da može ispravno prebaciti na drugi ekran!
     

      } else {
        await Firestore.instance
            .collection('users')
            .add({'brojTelefona': phoneNumber}).then((result) {
          Settings().setUserId(result.documentID);
        });
      }
    });
  }
}
