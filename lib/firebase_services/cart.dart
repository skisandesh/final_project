import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartService {
  final CollectionReference cartRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cartItem');

  Future<void> addToCart(productId, productName, quantity) async {
    final variable =
        await cartRef.where('productId', isEqualTo: productId.toString()).get();
    if (variable.docs.isNotEmpty) {
      Fluttertoast.showToast(msg: 'Already in cart');
    } else {
      cartRef.doc().set({'productId': productId});
      Fluttertoast.showToast(msg: 'Added to Cart');
    }
  }
}
