import 'package:final_year_project/Widget/custom_elevatedbutton.dart';
import 'package:final_year_project/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;
  const ErrorAlertDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(
        message,
        style: Constants.regularErrorText,
      ),
      actions: <Widget>[
        CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            buttonText: 'Ok',
            textStyle: Constants.boldHeadingBlack,
            color: Theme.of(context).primaryColor)
      ],
    );
  }
}
