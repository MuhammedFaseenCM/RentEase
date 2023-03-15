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
  final signupformKey = GlobalKey<FormState>();
  var picture = ''.obs;
  final ImagePicker picker = ImagePicker();
  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;
  set passwordVisible(bool value) {
    _passwordVisible = value;
  }

  TextEditingController get passwordController => signuppasswordController;

  set passwordController(TextEditingController value) {
    signuppasswordController = value;
  }

  TextEditingController get emailController => signupemailController;

  set emailController(TextEditingController value) {
    signupemailController = value;
  }

  Future<void> pickImage({required source, required context}) async {
    final image = await picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    picture.value = image.path;
    Navigator.of(context).pop();
  }

  void clearAll() {
    fullnameController.clear();
    numberController.clear();
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    locationController.clear();
    picture = ''.obs;
  }
}
