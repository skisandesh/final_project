import 'package:final_year_project/screens/login_screen.dart';
import 'package:final_year_project/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  const LoginRegisterButton({Key? key, required this.isRegister})
      : super(key: key);
  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Text(
            isRegister
                ? 'Already have an account ?'
                : 'Don\'t have an account ?',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: InkWell(
            onTap: () {
              isRegister
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
            },
            child: Text(
              isRegister ? 'Login' : 'Register',
              style: const TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
