import 'package:final_year_project/Widget/custom_elevatedbutton.dart';
import 'package:final_year_project/Widget/custom_text_field.dart';
import 'package:final_year_project/Widget/error_dialog.dart';
import 'package:final_year_project/Widget/login_register_button.dart';
import 'package:final_year_project/Widget/title_text.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/adaptive_and_responsive/responsive.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/firebase_services/authentication.dart';
import 'package:final_year_project/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) {
          return ErrorAlertDialog(message: msg);
        });
  }

  void submitForm() async {
    if (_cPasswordController.text != _passwordController.text) {
      displayDialog('password didn\'t match');
    } else if (_emailController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _cPasswordController.text.isNotEmpty) {
      String? _createUserFeedback = await AuthenticationServices().signupUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _usernameController.text.trim());
      _createUserFeedback != null
          ? displayDialog(_createUserFeedback)
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      displayDialog('please fill up form');
    }
  }

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
              SizedBox(
                height: _screenHeight * 0.1,
              ),
              const TitleText(),
              SizedBox(
                height: _screenHeight * 0.1,
              ),
              SizedBox(
                width: Adaptive.isMobile(context)
                    ? _screenWidth
                    : _screenWidth * 0.5,
                child: Column(
                  children: [
                    CustomTextField(
                      key: const ValueKey('username'),
                      controller: _usernameController,
                      data: Icons.person,
                      hintText: 'Username',
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      key: const ValueKey('email'),
                      controller: _emailController,
                      data: Icons.email,
                      hintText: 'email',
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      key: const ValueKey('cPassword'),
                      controller: _cPasswordController,
                      data: Icons.password,
                      hintText: 'confirm password',
                      isObscure: true,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      data: Icons.password,
                      hintText: 'password',
                      isObscure: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomElevatedButton(
                  onPressed: () => submitForm(),
                  buttonText: 'signup',
                  textStyle: Constants.boldHeadingWhite,
                  color: Theme.of(context).primaryColor),
              const SizedBox(
                height: 20,
              ),
              const LoginRegisterButton(isRegister: true),
            ],
          ),
        ),
      ),
    );
  }
}
