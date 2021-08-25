import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final bool isObscure;
  final TextInputType type;
  CustomTextField({
    required Key key,
    this.type = TextInputType.name,
    this.isObscure = false,
    required this.controller,
    required this.data,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xfff3f3f4),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(5.0),
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        obscureText: isObscure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Theme.of(context).primaryColor,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
