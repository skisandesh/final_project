import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OrderService extends ProductService {
  final CollectionReference orderRef = FirebaseFirestore.instance
      .collection('orders')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('orderItem');

  Future<void> addOrder(productId, productName, quantity, price) async {
    orderRef.doc(productName).set({
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'orderTime': DateFormat.MMMd().add_jm().format(DateTime.now()),
      'deadline': DateFormat.MMMd()
          .add_jm()
          .format(DateTime.now().add(Duration(days: 1)))
    });
  }

  Future getOrderItem() async {
    final snapshot = await orderRef.get();
    return snapshot.docs;
  }
}
