import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = FutureProvider<QuerySnapshot>((ref) {
  return CartService().getCartItem();
});
