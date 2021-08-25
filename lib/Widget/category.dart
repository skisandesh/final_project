import 'package:flutter/material.dart';

import '../constants.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () => setState(() {
                  clicked = !clicked;
                }),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Categories', style: Constants.regularPrimaryText),
                WidgetSpan(
                    child: Icon(clicked
                        ? Icons.expand_less_outlined
                        : Icons.expand_more_rounded))
              ]),
            )),
        if (clicked)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Hey'),
              Text('you'),
              Text('there'),
              Text('guys'),
              Text('aa'),
              Text('rock on')
            ],
          ),
      ],
    );
  }
}
