import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: "$email")
        .get();
  }

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: "$username")
        .get();
  }

  uploadUser(Map<String, dynamic> userInfos) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc()
        .set(userInfos)
        .catchError((e) {
      print("$e");
    });

    createChatRoom(String chatId, Map<String, dynamic> firstMessage) async {
      await FirebaseFirestore.instance
          .collection('charRooms')
          .doc(chatId)
          .set(firstMessage)
          .catchError((e) {
        print("$e");
      });
    }
  }
}
