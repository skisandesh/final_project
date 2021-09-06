import 'package:final_year_project/Widget/carousel.dart';
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

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();
    return Adaptive(
      mobile: DefaultTabController(
        initialIndex: 2,
        length: 3,
        child: SafeArea(
          child: Scaffold(
            key: _key,
            drawer: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: const MyDrawer()),
            body: NestedScrollView(
                // physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, isScolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      backgroundColor: Colors.white,
                      flexibleSpace: CustomAppBar(
                        keys: _key,
                      ),
                    ),
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      collapsedHeight: 320,
                      expandedHeight: 320,
                      flexibleSpace: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: MyDelegate(const TabBar(
                          indicatorColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: 'Categories',
                            ),
                            Tab(
                              text: 'Brand',
                            ),
                            Tab(
                              text: 'Shop',
                            )
                          ],
                        )))
                  ];
                },
                body: const TabBarView(
                    children: [ProductGrid(), ProductGrid(), ProductGrid()])),
          ),
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

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
