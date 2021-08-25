import 'dart:async';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:final_year_project/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    displaySplash();
  }

  displaySplash() {
    Timer(const Duration(seconds: 2), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.lightGreenAccent],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp)),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'Welcome',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/welcome.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'World Best Online Store',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
