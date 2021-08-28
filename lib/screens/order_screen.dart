import 'package:final_year_project/Widget/custom_appbarr.dart';
import 'package:final_year_project/Widget/custom_title_bar.dart';
import 'package:final_year_project/Widget/custom_top_bar.dart';
import 'package:final_year_project/Widget/drawer.dart';
import 'package:final_year_project/Widget/order_body.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = '/order';

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
            children: [CustomAppBar(keys: _key), OrderBody()],
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
                OrderBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
