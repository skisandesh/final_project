import 'package:final_year_project/Widget/custom_appbarr.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/firebase_services/cart.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(this.data, {Key? key}) : super(key: key);
  final dynamic data;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Adaptive(
        mobile: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                backgroundColor: Colors.white,
                leading:
                    Container(color: Colors.black54, child: const BackButton()),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.data['imageUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              body(widget.data),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () => CartService().addToCart(
                  widget.data['productId'], widget.data['productName'], 1),
              label: const Text('Add To Cart')),
        ),
        tablet: Container(),
        desktop: Container());
  }
}

Widget body(data) {
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        ListTile(
          title: const Text('Product'),
          trailing: Text('${data['productName']}'),
        ),
        ListTile(
          title: const Text('Price'),
          trailing: Text('${data['price']}'),
        ),
        ListTile(
          title: const Text('Description'),
          subtitle: Text('${data['description']}'),
        ),
      ],
    ),
  );
}
