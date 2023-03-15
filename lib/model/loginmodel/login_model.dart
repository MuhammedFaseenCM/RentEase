import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginModel extends GetxController {
  TextEditingController signinemailController = TextEditingController();
  TextEditingController signinpasswordController = TextEditingController();
  
  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;
  set passwordVisible(bool value) {
    _passwordVisible = value;
  }

  TextEditingController get passwordController => signinpasswordController;

  set passwordController(TextEditingController value) {
    signinpasswordController = value;
   
  }

  TextEditingController get emailController => signinemailController;

  set emailController(TextEditingController value) {
    signinemailController = value;
  }
}
