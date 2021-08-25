import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'E',
          style: TextStyle(
              color: Color(0xffe46b10),
              fontSize: 40,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: 'market',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }
}
