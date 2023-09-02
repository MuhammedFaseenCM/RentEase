import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;
  final RxBool obscureText = true.obs;

  void toggleObscureText() {
    obscureText.toggle();
  }

  
}