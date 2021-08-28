import 'package:final_year_project/Widget/carousel.dart';
import 'package:final_year_project/Widget/category.dart';
import 'package:final_year_project/Widget/custom_appbarr.dart';
import 'package:final_year_project/Widget/custom_body.dart';
import 'package:final_year_project/Widget/custom_text_field.dart';
import 'package:final_year_project/Widget/custom_title_bar.dart';
import 'package:final_year_project/Widget/custom_top_bar.dart';
import 'package:final_year_project/Widget/drawer.dart';
import 'package:final_year_project/Widget/product_grid.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();
    return Adaptive(
      mobile: Scaffold(
          key: _key,
          drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: const MyDrawer()),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    keys: _key,
                  ),
                  CustomTextField(
                      key: const ValueKey('search'),
                      controller: _searchController,
                      data: Icons.search,
                      hintText: 'search'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Carousel(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Categories(),
                  const ProductGrid(),
                  // ProductItem(),
                ],
              ),
            ),
          )),
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
                height: 10,
              ),
              CustomBody(),
              ProductGrid()
            ],
          ),
        )),
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
                  height: 10,
                ),
                CustomBody(),
                ProductGrid()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
