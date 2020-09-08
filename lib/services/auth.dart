import 'package:firebase_auth/firebase_auth.dart';
import 'package:EpiChat/lib.dart' as lib;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithMailAndAutologin(
      String epitechMail, String autologin) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: epitechMail, password: autologin);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithMailAndAutologin(
      String epitechMail, String autologin) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: epitechMail, password: autologin);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      await lib.setStringValue('firebase_uid', null);
    } catch (e) {
      print(e.toString());
    }
  }
}
