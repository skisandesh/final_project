import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

final uId = _firebaseAuth.currentUser!.uid;

class UserService {
  final CollectionReference userRef = _firebaseFirestore.collection('Users');

  Future<DocumentSnapshot<Object?>>? getUserInfo() async {
    DocumentSnapshot snapshot = await userRef.doc(uId).get();
    return snapshot;
  }

  Future<void> saveUserInfo(
      username, imgUrl, phoneNumber, state, vdcmun, city, location, sex) async {
    await userRef.doc(uId).update({
      'username': username,
      'imgUrl': imgUrl,
      'phoneNumber': phoneNumber,
      'state': state,
      'vdcMun': vdcmun,
      'city': city,
      'location': location,
      'sex': sex
    });
  }
}
