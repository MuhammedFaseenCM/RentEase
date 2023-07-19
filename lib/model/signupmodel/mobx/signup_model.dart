import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpModel extends GetxController {
  TextEditingController signupemailController = TextEditingController();
  TextEditingController signuppasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool _passwordVisible = false;

  
  bool get passwordVisible => _passwordVisible;

  final ImagePicker picker = ImagePicker();

 
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
  }


  String picture = '';

  
  Future<void> pickImage({required source, required context}) async {
    final image = await picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    picture = image.path;
    Navigator.of(context).pop();
  }

  
  void clearAll() {
    fullnameController.clear();
    numberController.clear();
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    locationController.clear();
    picture = '';
  }

  
  GlobalKey<FormState> signupformKey = GlobalKey<FormState>();




  TextEditingController get passwordController => signuppasswordController;

  set passwordController(TextEditingController value) {
    signuppasswordController = value;
  }

  TextEditingController get emailController => signupemailController;

  set emailController(TextEditingController value) {
    signupemailController = value;
  }
}
