import 'package:final_year_project/Widget/title_text.dart';
import 'package:flutter/material.dart';

import 'cart_badge.dart';
import 'drawer.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key, required this.keys}) : super(key: key);
  GlobalKey<ScaffoldState> keys;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: MediaQuery.of(context).size.width < 255
            ? null
            : const EdgeInsets.all(15),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0)],
          begin: const Alignment(0, 0),
          end: const Alignment(0, 1),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  keys.currentState!.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                )),
            const TitleText(),
            const CartBadge(),
          ],
        ));
  }
}
