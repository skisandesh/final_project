import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../constants.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'My Cart',
          style: Constants.headingPrimaryText,
        ),
        SizedBox(
          height: 40,
        ),
        FutureBuilder(
            future: CartService().getCartItem(),
            builder: (ctx, dynamic snapshot) {
              if (snapshot.hasError) {
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.warning),
                      ),
                      Text('Error in loading data')
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    Map<String, dynamic> cartData =
                        snapshot.data[index].data() as Map<String, dynamic>;
                    return cartItem(cartData, context);
                  },
                );
              }
              return Text('Nothing on Carts');
            })
      ],
    );
  }

  Widget cartItem(data, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 100,
              width: 500,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(data['imgUrl']),
                    radius: 40,
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
                        onPressed: () {},
                        icon: Icon(Icons.remove),
                        splashRadius: 0.1,
                      ),
                      Text('1'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        splashRadius: 0.1,
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
