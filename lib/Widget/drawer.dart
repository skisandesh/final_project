import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/userinfo.dart';
import 'package:final_year_project/screens/cart_screen.dart';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:final_year_project/screens/login_screen.dart';
import 'package:final_year_project/screens/order_screen.dart';
import 'package:final_year_project/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  Widget user(String text, image) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(image),
            radius: 35,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          FutureBuilder<DocumentSnapshot>(
              future: UserService().getUserInfo(),
              builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapShot) {
                if (snapShot.hasError) {
                  return const LinearProgressIndicator();
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                } else {
                  Map<String, dynamic> data =
                      snapShot.data!.data() as Map<String, dynamic>;
                  return user(data['email'].toString(), data['imgUrl']);
                }
              }),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
            },
            minLeadingWidth: 1,
            leading: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: const Text(
              "Home",
              style: Constants.regularDarkText,
            ),
          ),
          ListTile(
            minLeadingWidth: 1,
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ProfileScreen())),
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text(
              "Profile",
              style: Constants.regularDarkText,
            ),
          ),
          ListTile(
            minLeadingWidth: 1,
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const CartScreen())),
            leading: const Icon(Icons.shopping_cart, color: Colors.black),
            title: const Text(
              "Cart",
              style: Constants.regularDarkText,
            ),
          ),
          ListTile(
            minLeadingWidth: 1,
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const OrderScreen())),
            leading: const Icon(Icons.card_travel, color: Colors.black),
            title: const Text(
              "Order",
              style: Constants.regularDarkText,
            ),
          ),
          ListTile(
            minLeadingWidth: 1,
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())));
            },
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text(
              "Logout",
              style: Constants.regularDarkText,
            ),
          ),
        ],
      ),
    );
  }
}
