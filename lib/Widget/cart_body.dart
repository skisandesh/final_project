import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:final_year_project/firebase_services/order.dart';
import 'package:final_year_project/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        Consumer(
          builder: (context, ref, child) {
            final cartData = ref(cartProvider);
            return cartData.when(
                data: (value) => ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: value.docs.length,
                      itemBuilder: (ctx, index) {
                        Map<String, dynamic> data =
                            value.docs as Map<String, dynamic>;
                        return cartItem(data[index], context);
                      },
                    ),
                loading: () => const CircularProgressIndicator(),
                error: (_, e) => const Text('error'));
          },
        )
      ],
    );
  }

  Widget cartItem(data, context) {
    return Row(
      mainAxisAlignment: Adaptive.isMobile(context)
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 5,
          child: Card(
              elevation: 10,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 100,
                width: Adaptive.isMobile(context)
                    ? 400
                    // ? MediaQuery.of(context).size.width
                    : 500,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(data['imageUrl']),
                      radius: Adaptive.isMobile(context) ? 20 : 40,
                    ),
                    Flexible(child: Text(data['productName'])),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Rs: ${data['price']}'),
                        IconButton(
                            onPressed: () {
                              CartService()
                                  .deleteCartItem(data['productId'].toString());
                              setState(() {});
                            },
                            splashRadius: 0.1,
                            icon: Icon(
                              Icons.remove_shopping_cart_outlined,
                              color: Theme.of(context).primaryColor,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => isZero
                              ? null
                              : CartService().subQuantiy(data['productId']),
                          icon: const Icon(Icons.remove),
                          splashRadius: 0.1,
                        ),
                        StreamBuilder(
                            stream: CartService()
                                .cartRef
                                .doc(data['productId'])
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
                                return Text(data['quantity'].toString());
                              }
                              return Text('0');
                            }),
                        IconButton(
                          onPressed: () =>
                              CartService().addQuantiy(data['productId']),
                          icon: Icon(Icons.add),
                          splashRadius: 0.1,
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
        const SizedBox(
          width: 25,
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              OrderService().addOrder(data['productId'], data['productName'],
                  quantity, data['price']);
              CartService().deleteCartItem(data['productId'].toString());
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('added to order')));
              setState(() {});
            },
            child: Text(
              'Order Now',
              style: Adaptive.isMobile(context)
                  ? Constants.regularPrimaryText
                  : Constants.headingPrimaryText,
            ),
          ),
        ),
      ],
    );
  }
}
