import 'package:final_year_project/Widget/custom_appbarr.dart';
import 'package:final_year_project/Widget/custom_title_bar.dart';
import 'package:final_year_project/Widget/custom_top_bar.dart';
import 'package:final_year_project/Widget/drawer.dart';
import 'package:final_year_project/Widget/profile_body.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _keys = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Adaptive(
      mobile: Scaffold(
        key: _keys,
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const MyDrawer()),
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                keys: _keys,
              ),
              const ProfileBody()
            ],
          ),
        ),
      ),
      tablet: Scaffold(
        body: Column(children: const [
          TopBar(),
          SizedBox(
            height: 10,
          ),
          TitleBar(),
        ]),
      ),
      desktop: Scaffold(
        body: Column(children: const [
          TopBar(),
          SizedBox(
            height: 10,
          ),
          TitleBar(),
          SizedBox(
            height: 50,
          ),
          ProfileBody(),
        ]),
      ),
    );
  }
}
