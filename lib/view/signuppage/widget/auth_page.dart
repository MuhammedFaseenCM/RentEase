
import 'package:flutter/material.dart';
import 'package:rentease/view/loginpage/login_screen.dart';
import 'package:rentease/view/signuppage/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin ? const LoginPage() : const SignUpScreen();
}
