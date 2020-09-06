import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EpiChat/modal/user.dart';

class DatabaseMethods {
  getUserByUsername() {}

  uploadUser(Map<String, dynamic> userInfos) {
    FirebaseFirestore.instance.collection('users').doc().set(userInfos);
  }
}
