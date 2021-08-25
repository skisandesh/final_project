import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Constants {
  static const regularHeading = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const boldHeadingBlack = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const boldHeadingWhite = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.white);

  static const regularDarkText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const headingPrimaryText = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w600, color: Color(0xffe46b10));
  static const headingWhiteText = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white);

  static const regularPrimaryText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xffe46b10));

  static const regularErrorText = TextStyle(fontSize: 16, color: Colors.red);
}
