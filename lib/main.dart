import 'package:final_year_project/screens/cart_screen.dart';
import 'package:final_year_project/screens/edit_profile.dart';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:final_year_project/screens/login_screen.dart';
import 'package:final_year_project/screens/order_screen.dart';
import 'package:final_year_project/screens/profile_screen.dart';
import 'package:final_year_project/screens/register_screen.dart';
import 'package:final_year_project/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: const Color(0xffe46b10),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreen(),
        CartScreen.routeName: (ctx) => CartScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        OrderScreen.routeName: (ctx) => OrderScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
      },
    );
  }
}
