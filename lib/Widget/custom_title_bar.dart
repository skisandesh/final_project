import 'package:final_year_project/Widget/title_text.dart';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'cart_badge.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 10,
        ),
        InkWell(
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen())),
            child: const TitleText()),
        Container(
          width: 350,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: Center(
              child: TextFormField(
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'search',
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                )),
          )),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: const CartBadge(),
        )
      ],
    );
  }
}
