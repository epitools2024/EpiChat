import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser!;

  Future<bool> signInWithMailAndPassword(
    String mail,
    String password,
  ) async {
    bool isOk = true;
    try {
      await _auth.signInWithEmailAndPassword(email: mail, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        isOk = false;
        debugPrint("L'email que vous avez entré n'existe pas dans ce monde");
      } else if (e.code == 'wrong-password') {
        isOk = false;
        debugPrint("Mot de passe incorrect");
      } else {
        isOk = false;
        debugPrint("Une erreur inconnue s'est produite.\nCode:\n${e.code}");
      }
    }
    return isOk;
  }

  Future signUpWithMailAndPassword(
    String mail,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: mail, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint("Sign up error.\nCode:\n${e.code}");
    }
  }

  Future signOut(Function? afterSignOut) async {
    try {
      await _auth.signOut();
      if (afterSignOut != null) afterSignOut();
    } catch (e) {
      print(e.toString());
      debugPrint("Logout.\nCode:\n${e.toString()}");
    }
  }
}
