import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/authentication.dart';

class ProductService extends AuthenticationServices {
  final CollectionReference productRef =
      FirebaseFirestore.instance.collection('products');

  // Future<void> getProductItem()async{
  //   await productRef.doc()
  // }
  Future getImage() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('test').get();
    return snapshot.docs;
  }

  Future getProduct() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    return snapshot.docs;
  }
}
