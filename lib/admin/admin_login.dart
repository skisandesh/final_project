import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/Widget/custom_text_field.dart';
import 'package:final_year_project/Widget/error_dialog.dart';
import 'package:final_year_project/Widget/title_text.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/admin/admin_home.dart';
import 'package:final_year_project/admin/upload_items.dart';
import 'package:final_year_project/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AdminSignInPage extends StatefulWidget {
  const AdminSignInPage({Key? key}) : super(key: key);

  @override
  _AdminSignInPageState createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  final _adminIdTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
                )
              ],
            ),
            SizedBox(
              height: _screenHeight * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TitleText(),
              ],
            ),
            const Text('All Products'),
            SizedBox(
              height: _screenHeight * 0.1,
            ),
            const Text(
              'Admin Login ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: _screenHeight * 0.07,
            ),
            SizedBox(
              width: Adaptive.isMobile(context)
                  ? _screenWidth
                  : _screenWidth * 0.5,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        key: const ValueKey('Admin'),
                        controller: _adminIdTextEditingController,
                        data: Icons.person,
                        hintText: 'iD',
                      ),
                      CustomTextField(
                        key: const ValueKey('password'),
                        controller: _passwordTextEditingController,
                        data: Icons.password,
                        hintText: 'password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: _screenWidth * 0.9,
                            height: _screenHeight * 0.07),
                        child: ElevatedButton(
                          onPressed: () {
                            _adminIdTextEditingController.text.isNotEmpty &&
                                    _passwordTextEditingController
                                        .text.isNotEmpty
                                ? loginAdmin()
                                : showDialog(
                                    context: context,
                                    builder: (c) {
                                      return const ErrorAlertDialog(
                                          message:
                                              'Please provide the account');
                                    });
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffe46b10))),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection('admins').get().then((adminSnapshot) {
      for (var admin in adminSnapshot.docs) {
        if (admin.data()['id'] != _adminIdTextEditingController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Not a Admin'), duration: Duration(seconds: 1)));
        } else if (admin.data()['password'] !=
            _passwordTextEditingController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('password did not match'),
              duration: Duration(seconds: 1)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Welcome Admin' + admin.data()['name']),
            duration: const Duration(seconds: 2),
          ));
          setState(() {
            _adminIdTextEditingController.text = '';
            _passwordTextEditingController.text = '';
          });
          Route route =
              MaterialPageRoute(builder: (c) => const AdminHomeScreen());
          Navigator.pushReplacement(context, route);
        }
      }
    });
  }
}
