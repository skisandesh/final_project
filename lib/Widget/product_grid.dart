import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:final_year_project/firebase_services/product.dart';
import 'package:final_year_project/screens/product_detail.dart';
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
            return const Text("Something went wrong");
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
            child: LinearProgressIndicator(),
          );
        });
  }

  Widget productCard(data, context) {
    return GridTile(
        child: InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ProductDetailScreen(data))),
      child: Card(
          color: Colors.white,
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.network(
                  data['imageUrl'],
                  width: 180,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      data['productName'],
                      style: Constants.regularDarkText,
                    ),
                    IconButton(
                        onPressed: () => CartService().addToCart(
                            data['productId'], data['productName'], 1),
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                )
              ],
            ),
          )),
    ));
  }
}
