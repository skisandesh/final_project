import 'package:final_year_project/Widget/title_text.dart';
import 'package:flutter/material.dart';

import 'cart_badge.dart';
import 'drawer.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key, required this.keys}) : super(key: key);
  GlobalKey<ScaffoldState> keys;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          onPressed: () {
            keys.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          )),
      const TitleText(),
      const CartBadge(),
    ]);
  }
}
