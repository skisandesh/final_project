import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:final_year_project/firebase_services/product.dart';
import 'package:flutter/material.dart';

import '../color_filter.dart';
import '../constants.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProductService().getProduct(),
        builder: (ctx, dynamic snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: Adaptive.isMobile(context)
                    ? const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20)
                    : const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctx, index) {
                  Map<String, dynamic> data =
                      snapshot.data[index].data() as Map<String, dynamic>;
                  return productCard(data, context);
                });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget productCard(data, context) {
    return Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 100,
          width: 100,
          child: GridTile(
            child: Image.network(
              data['imageUrl'],
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(
                data['productName'],
                style: Constants.boldHeadingWhite,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  CartService()
                      .addToCart(data['productId'], data['productName'], '1');
                },
              ),
            ),
          ),
        ));
  }
}
