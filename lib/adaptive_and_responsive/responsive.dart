import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;
  const Responsive({Key? key,required this.portrait,required this.landscape}) : super(key: key);

  static bool isPortrait(BuildContext context)=> MediaQuery.of(context).orientation == Orientation.portrait;
  static bool isLandscape(BuildContext context)=> MediaQuery.of(context).orientation == Orientation.landscape;
  static bool isIOS(BuildContext context) => Theme.of(context).platform == TargetPlatform.iOS;
  static bool isAndroid(BuildContext context) => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context,orientation){
          if(orientation == Orientation.portrait){
            return portrait;
          }
          else{
            return landscape;
          }
        }
    );
  }
}
