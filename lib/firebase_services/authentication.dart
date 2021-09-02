import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/Widget/error_dialog.dart';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widget/loading_dialog.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");

  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  Future<String?> signupUser(
      String email, String password, String username) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        usersRef.doc(getUserId()).set({
          'email': email,
          'username': username,
        });
      });
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code.toString() == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> loginUser(context, email, password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (c) => const LoadingAlertDialog(
              message: 'Authenticating,Please wait....',
            ));
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        const ErrorAlertDialog(message: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) => ErrorAlertDialog(message: e.code.toString()));
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (_) => ErrorAlertDialog(
                message: e.toString(),
              ));
    }
  }
}
