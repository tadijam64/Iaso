import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iaso/Common/Settings.dart';

class PoolInteractor {
  Future<void> saveData(String name, int age) async {
    DocumentReference postRef =
        Firestore.instance.document("users/" + Settings().userId);

    await Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      if (postSnapshot.exists) {
        await tx.update(postRef, <String, dynamic>{'name': name, 'age': age});
      }
    });
  }
}
