import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Models/User/User.dart';

class GetUserInteractor {
  var firestore = Firestore.instance;

  Future<User> getUserByPhoneNumber(String phoneNumber) {
    return Firestore.instance
        .collection('users')
        .where("phoneNumber", isEqualTo: phoneNumber)
        .getDocuments()
        .then((onData) {
      if (onData.documents.length > 0) {
        return User.fromJson(
            onData.documents[0].documentID, onData.documents[0].data);
      } else {
        return null;
      }
    });
  }
}
