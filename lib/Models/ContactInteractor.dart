import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';

class ContactInteractor {
  Future<void> saveData(String number) async {
    await Firestore.instance
        .collection('users/' + Settings().userId + "/contacts")
        .document(number)
        .setData({'phoneNumber': number, 'accepted': false});
  }

  Future<Map<String, bool>> getRequested() async {
    Map<String, bool> ret = new Map<String, bool>();
    QuerySnapshot data = await Firestore.instance
        .collection('users/' + Settings().userId + "/contacts")
        .getDocuments();

    data.documents.forEach((f) {
      ret[f["phoneNumber"]] = f["accepted"] ?? false;
    });

    return ret;
  }
}
