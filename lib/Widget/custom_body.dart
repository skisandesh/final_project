import 'package:final_year_project/Widget/category.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'carousel.dart';

class CustomBody extends StatefulWidget {
  const CustomBody({Key? key}) : super(key: key);

  @override
  _CustomBodyState createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 200,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Categories(),
          ),
          Expanded(
              flex: 2,
              child:
                  Container(color: Colors.grey[200], child: const Carousel())),
          Expanded(flex: 2, child: Image.asset('assets/images/welcome.png')),
        ],
      ),
    );
  }
}
