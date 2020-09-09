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
  }

  createChatRoom(String chatroomId, Map<String, dynamic> chatRoomData) async {
    await FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatroomId)
        .set(chatRoomData)
        .catchError((e) {
      print("$e");
    });
  }

  addConversationMessage(
      String chatroomId, Map<String, dynamic> message) async {
    return await FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatroomId)
        .collection("chats")
        .add(message)
        .catchError((e) {
      print("${e.toString()}");
    });
  }

  getConversationMessages(String chatroomId) async {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatroomId)
        .collection("chats")
        .orderBy('time')
        .snapshots()
        .asBroadcastStream();
  }

  getChatRooms(String usermail) {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .where('users', arrayContains: usermail)
        .snapshots()
        .asBroadcastStream();
  }
}
