import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/adaptive_and_responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final TextStyle textStyle;
  final Color color;

  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      required this.textStyle,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Adaptive.isMobile(context) ? 120 : 200,
        height: 50,
        child: Responsive.isIOS(context)
            ? CupertinoButton(
                onPressed: () => onPressed(),
                child:
                    const Text('test', style: TextStyle(color: Colors.white)),
                color: CupertinoColors.black,
              )
            : ElevatedButton(
                onPressed: () => onPressed(),
                child: Text(
                  buttonText,
                  style: textStyle,
                ),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(color),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
              ));
  }
}
