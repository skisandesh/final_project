import 'package:final_year_project/Widget/cart_body.dart';
import 'package:final_year_project/Widget/custom_appbarr.dart';
import 'package:final_year_project/Widget/custom_title_bar.dart';
import 'package:final_year_project/Widget/custom_top_bar.dart';
import 'package:final_year_project/Widget/drawer.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    return Adaptive(
      mobile: SafeArea(
        child: Scaffold(
          key: _key,
          drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: const MyDrawer()),
          body: (Column(
            children: [CustomAppBar(keys: _key), CartBody()],
          )),
        ),
      ),
      tablet: Container(
        color: Colors.grey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: const [
                TopBar(),
                SizedBox(
                  height: 10,
                ),
                TitleBar(),
                SizedBox(
                  height: 20,
                ),
                CartBody()
              ],
            ),
          ),
        ),
      ),
      desktop: Container(
        color: Colors.grey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: const [
                TopBar(),
                SizedBox(
                  height: 10,
                ),
                TitleBar(),
                SizedBox(
                  height: 20,
                ),
                CartBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
