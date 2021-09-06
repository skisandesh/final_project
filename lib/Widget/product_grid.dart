import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:final_year_project/providers/product_provider.dart';
import 'package:final_year_project/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final product = ref(productProvider);
      return product.when(
          data: (prod) => GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                gridDelegate: Adaptive.isMobile(context)
                    ? const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      )
                    : const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                itemCount: prod.length,
                itemBuilder: (BuildContext ctx, index) {
                  return productCard(prod[index], context);
                },
              ),
          loading: () => const CircularProgressIndicator(),
          error: (_, e) => const CircularProgressIndicator());
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
    // return Card(
    //     elevation: 10,
    //     clipBehavior: Clip.antiAlias,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //     child: SizedBox(
    //       height: 100,
    //       width: 100,
    //       child: GridTile(
    //         child: Image.network(
    //           data['imageUrl'],
    //           fit: BoxFit.cover,
    //         ),
    //         footer: GridTileBar(
    //           backgroundColor: Colors.black87,
    //           title: Text(
    //             data['productName'],
    //             style: Constants.boldHeadingWhite,
    //           ),
    //           trailing: IconButton(
    //             icon: Icon(
    //               Icons.shopping_cart,
    //               color: Theme.of(context).primaryColor,
    //             ),
    //             onPressed: () {
    //               CartService()
    //                   .addToCart(data['productId'], data['productName'], '1');
    //             },
    //           ),
    //         ),
    //       ),
    //     ));
  }
}
