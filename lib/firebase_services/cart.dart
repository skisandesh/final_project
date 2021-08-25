import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartService extends ProductService {
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
      cartRef.doc(productId).set({'productId': productId});
      Fluttertoast.showToast(msg: 'Added to Cart');
    }
  }

  getCartItem() async {
    List productId = [];
    final cartItem = await cartRef.get();
    cartItem.docs.forEach((element) {
      productId.add(element['productId'].toString());
    });
    final snapshot =
        await productRef.where('productId', whereIn: productId).get();
    return snapshot.docs;
  }

  Future<void> deleteCartItem(productId) async {
    await cartRef.doc(productId).delete();
  }

  Future<void> addQuantiy(productId) async {
    await cartRef.doc(productId).update({'quantity': FieldValue.increment(1)});
  }

  Future<void> subQuantiy(productId) async {
    await cartRef.doc(productId).update({'quantity': FieldValue.increment(-1)});
  }
}
