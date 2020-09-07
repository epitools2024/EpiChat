import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EpiChat/services/user.dart';

class DatabaseMethods {
  getUserByUsername() {}

  uploadUser(Map<String, dynamic> userInfos) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc()
        .set(userInfos)
        .catchError((e) {
      print("$e");
    });
  }
}
