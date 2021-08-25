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
      children: [
        IconButton(
          splashRadius: 0.1,
          icon: Icon(
            Icons.shopping_cart,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const CartScreen()));
          },
        ),
        Positioned(
            child: Stack(
          children: [
            const Icon(
              Icons.brightness_1,
              size: 20.0,
              color: Colors.black,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: CartService().cartRef.snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return cartCount('-');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return cartCount('-');
                  }
                  return cartCount(snapshot.data!.docs.length.toString());
                }),
          ],
        ))
      ],
    );
  }
}

Widget cartCount(value) {
  return Positioned(
      top: 4.0,
      bottom: 4.0,
      left: 6.0,
      child: Text(
        value,
        style: TextStyle(fontSize: 10, color: Colors.white),
      ));
}
