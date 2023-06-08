import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_/screens/boarding_screen.dart';
import 'package:flutter_news_/screens/home.dart';
import 'package:flutter_news_/screens/login_screen.dart';
import 'package:open_file/open_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

class AppUser extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  final storage = FirebaseStorage.instance;
  AppUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _user = userCredential.user;

      Fluttertoast.showToast(msg: 'Log In successful');
      Navigator.pushReplacementNamed(context, Home.routeName);

      print('Sign in successful. User: $_user');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      } else {
        throw e.toString();
      }
    }
  }

  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Navigator.pushReplacementNamed(context, Home.routeName);
      Fluttertoast.showToast(msg: 'Signed in with a temporary account.');
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

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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

      Fluttertoast.showToast(msg: 'Sign up successful.');
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

  Future<String> uploadImagetoStorage(String Childname, Uint8List file) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

    Reference ref = _storage.ref('ProfilePicture').child(Childname);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getPhotoUrlFromStorage() async {
    try {
      final Reference ref = FirebaseStorage.instanceFor(
        bucket: 'news-apps-e748b.appspot.com',
      ).ref().child('ProfilePicture/${user?.displayName}');

      final String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error retrieving photo URL from storage: $e');
      return '';
    }
  }

  Future<void> updateProfile({
    String? displayName,
    String? email,
    String? phoneNumber,
  }) async {
    try {
      // Update display name if provided
      if (displayName != null) {
        await user?.updateDisplayName(displayName);
        print('Display name updated: $displayName');
      }

      // Update email if provided
      if (email != null) {
        await user?.updateEmail(email);
        print('Email updated: $email');
      }

      // Update phone number if provided
      // if (phoneNumber != null) {
      //   await user?.updatePhoneNumber(PhoneAuthProvider.credential(
      //     verificationId: 'your_verification_id',
      //     smsCode: 'your_sms_code',
      //   ));
      //   print('Phone number updated: $phoneNumber');
      // }

      // Update photo URL using image from Firebase Storage
      String photoUrl = await getPhotoUrlFromStorage();
      if (photoUrl.isNotEmpty) {
        await user?.updatePhotoURL(photoUrl);
        print('Profile picture URL updated: $photoUrl');
      }

      print('Profile updated successfully');
      Fluttertoast.showToast(msg: 'Profile updated successfully');
    } catch (e) {
      print('Error updating profile: $e');
    }
  }
}
