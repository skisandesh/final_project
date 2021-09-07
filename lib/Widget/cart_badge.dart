import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:final_year_project/screens/cart_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const CartScreen())),
          child: const Icon(
            Icons.shopping_cart,
          ),
        ),
        Positioned(
          right: 0.0,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(
              minWidth: 13,
              minHeight: 13,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: StreamBuilder<QuerySnapshot>(
                  stream: CartService().cartRef.snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasError) {
                      return count('-');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return count('-');
                    }
                    return count(snapshot.data!.docs.length.toString());
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

Widget count(value) {
  return Text(
    '${value}',
    style: TextStyle(
      color: Colors.white,
      fontSize: 8,
    ),
    textAlign: TextAlign.center,
  );
}
