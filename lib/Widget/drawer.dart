import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/firebase_services/userinfo.dart';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:final_year_project/screens/login_screen.dart';
import 'package:final_year_project/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  Widget user(String text) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 60,
        ),
        const SizedBox(
          height: 40,
        ),
        Align(alignment: Alignment.bottomRight, child: Text(text)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.blue,
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                    future: UserService().getUserInfo(),
                    builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapShot) {
                      if (snapShot.hasError) {
                        return user('......');
                      } else if (snapShot.connectionState ==
                          ConnectionState.waiting) {
                        return user('loading');
                      } else {
                        Map<String, dynamic> data =
                            snapShot.data!.data() as Map<String, dynamic>;
                        return user(data['email'].toString());
                      }
                    })
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
            },
            leading: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text(
              "Home",
              style: Constants.regularPrimaryText,
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ProfileScreen())),
            leading: Icon(Icons.person, color: Theme.of(context).primaryColor),
            title: const Text(
              "Profile",
              style: Constants.regularPrimaryText,
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart,
                color: Theme.of(context).primaryColor),
            title: const Text(
              "Cart",
              style: Constants.regularPrimaryText,
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.card_travel, color: Theme.of(context).primaryColor),
            title: const Text(
              "Order",
              style: Constants.regularPrimaryText,
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())));
            },
            leading: Icon(Icons.logout, color: Theme.of(context).primaryColor),
            title: const Text(
              "Logout",
              style: Constants.regularPrimaryText,
            ),
          ),
        ],
      ),
    );
  }
}
