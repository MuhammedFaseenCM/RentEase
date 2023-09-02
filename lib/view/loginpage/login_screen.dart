import 'package:flutter/material.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/loginpage/widgets/header_section.dart';
import 'package:rentease/view/loginpage/widgets/login_section.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: _boxDecoration(),
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: [
                HeaderSection(
                  title: logintext,
                  subtitle: welcomeBack,
                ),
                LoginSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.orange[900]!,
          Colors.orange[800]!,
          Colors.orange[400]!,
        ],
      ),
    );
  }
}
