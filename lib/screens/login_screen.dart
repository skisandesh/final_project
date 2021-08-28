import 'package:final_year_project/Widget/login_register_button.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/admin/admin_login.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/Widget/custom_elevatedbutton.dart';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:final_year_project/Widget/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Widget/error_dialog.dart';
import '../Widget/loading_dialog.dart';
import '../Widget/custom_text_field.dart';
import '../firebase_services/authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/signin';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextEditingController = TextEditingController();
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (_) => const AdminSignInPage())),
                  child: const Text(
                    'Admin',
                    style: Constants.regularPrimaryText,
                  ),
                ),
              ),
              SizedBox(
                height: _screenHeight * 0.1,
              ),
              const TitleText(),
              const Text('All Products'),
              SizedBox(
                height: _screenHeight * 0.15,
              ),
              SizedBox(
                width: Adaptive.isMobile(context)
                    ? _screenWidth
                    : _screenWidth * 0.5,
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      CustomTextField(
                          key: const ValueKey('email'),
                          controller: _emailTextEditingController,
                          data: Icons.email,
                          hintText: 'email',
                          isObscure: false),
                      CustomTextField(
                          key: const ValueKey('password'),
                          controller: _passwordTextEditingController,
                          data: Icons.password,
                          hintText: 'password',
                          isObscure: true),
                    ])),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                color: Theme.of(context).primaryColor,
                buttonText: 'Login',
                textStyle: Constants.boldHeadingWhite,
                onPressed: () {
                  _emailTextEditingController.text.isNotEmpty &&
                          _passwordTextEditingController.text.isNotEmpty
                      ? AuthenticationServices().loginUser(
                          context,
                          _emailTextEditingController.text.trim(),
                          _passwordTextEditingController.text.trim())
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return const ErrorAlertDialog(
                                message: 'Please provide the account');
                          });
                },
              ),
              const SizedBox(height: 10),
              const LoginRegisterButton(isRegister: false),
            ],
          ),
        ),
      ),
    );
  }
}
