import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:final_year_project/firebase_services/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  bool isZero = false;
  late int quantity;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'My Cart',
          style: Constants.headingPrimaryText,
        ),
        const SizedBox(
          height: 40,
        ),
        FutureBuilder(
            future: CartService().getCartItem(),
            builder: (ctx, dynamic snapshot) {
              if (snapshot.hasError) {
                Column(
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.warning),
                    ),
                    Text('Error in loading data')
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LinearProgressIndicator());
              } else if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    Map<String, dynamic> cartData =
                        snapshot.data[index].data() as Map<String, dynamic>;
                    return cartItem(cartData, context);
                  },
                );
              }
              return const Text('Nothing on Carts');
            })
      ],
    );
  }

  Widget cartItem(prod, context) {
    return Dismissible(
      key: ValueKey(prod['productId']),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      onDismissed: (direction) {
        CartService().deleteCartItem(prod['productId'].toString());
      },
      child: Card(
        child: Row(
          mainAxisAlignment: Adaptive.isMobile(context)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image.network(prod['imageUrl']),
                  ),
                  Flexible(child: Text(prod['productName'])),
                  StreamBuilder(
                      stream: CartService()
                          .cartRef
                          .doc(prod['productId'])
                          .snapshots(),
                      builder: (ctx, dynamic snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('()');
                        } else if (snapshot.connectionState ==
                            ConnectionState.active) {
                          var data = snapshot.data;
                          quantity = data['quantity'];
                          if (quantity == 1) {
                            isZero = true;
                          } else {
                            isZero = false;
                          }
                          // return Text(data['quantity'].toString());
                          return Column(
                            children: [
                              Text('Rs   ${prod['price'] * data['quantity']}'),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => isZero
                                        ? null
                                        : CartService()
                                            .subQuantiy(data['productId']),
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 15,
                                    ),
                                    splashRadius: 0.1,
                                  ),
                                  Text(data['quantity'].toString()),
                                  IconButton(
                                    onPressed: () => CartService()
                                        .addQuantiy(data['productId']),
                                    icon: Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                    splashRadius: 0.1,
                                  )
                                ],
                              ),
                            ],
                          );
                        }
                        return Text('0');
                      }),
                  // IconButton(
                  //     onPressed: () {
                  //       CartService()
                  //           .deleteCartItem(prod['productId'].toString());
                  //       setState(() {});
                  //     },
                  //     splashRadius: 0.1,
                  //     icon: Icon(
                  //       Icons.remove_shopping_cart_outlined,
                  //       color: Colors.black,
                  //     ))
                ],
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  OrderService().addOrder(prod['productId'],
                      prod['productName'], quantity, prod['price']);
                  CartService().deleteCartItem(prod['productId'].toString());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('added to order')));
                  setState(() {});
                },
                child: Text(
                  'Order',
                  style: Adaptive.isMobile(context)
                      ? Constants.regularPrimaryText
                      : Constants.headingPrimaryText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
