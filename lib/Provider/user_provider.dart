import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  AppUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _user = userCredential.user;
      print('Sign in successful. User: $_user');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        throw e.toString();
      }
    }
  }

  Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with a temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      _user = userCredential.user;
      _user?.updateDisplayName(name);
      print('Sign up successful. User: $_user');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
    return true;
  }
}
