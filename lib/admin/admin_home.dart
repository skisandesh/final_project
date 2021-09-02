import 'package:final_year_project/admin/adminOrderDetails.dart';
import 'package:final_year_project/admin/upload_items.dart';
import 'package:final_year_project/firebase_services/product.dart';
import 'package:final_year_project/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Panel'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const UploadPage()));
                },
                icon: Icon(Icons.add)),
            PopupMenuButton(
                itemBuilder: (_) => [
                      PopupMenuItem(
                          child: TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const AdminOrderScreen())),
                        child: Text('Order'),
                      )),
                      PopupMenuItem(
                          child: TextButton(
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (c) => const LoginScreen());
                          Navigator.push(context, route);
                        },
                        child: Text('Logout'),
                      ))
                    ]),
          ],
        ),
        body: FutureBuilder(
            future: ProductService().getProduct(),
            builder: (ctx, dynamic snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) {
                      Map<String, dynamic> data =
                          snapshot.data[index].data() as Map<String, dynamic>;
                      return productView(data, context);
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

Widget productView(data, context) {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: NetworkImage(data['imageUrl']),
      radius: 20,
    ),
    title: Text(data['productName']),
    trailing: IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => UploadPage(
                  data: data,
                )));
      },
      icon: Icon(Icons.edit),
    ),
  );
}
