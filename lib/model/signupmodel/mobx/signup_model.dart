import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'signup_model.g.dart';

class SignUpModel = _SignUpModelBase with _$SignUpModel;

abstract class _SignUpModelBase with Store {
  TextEditingController signupemailController = TextEditingController();
  TextEditingController signuppasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @observable
  TextEditingController codeController = TextEditingController();






  @observable
  bool _passwordVisible = false;

  @computed
  bool get passwordVisible => _passwordVisible;

  final ImagePicker picker = ImagePicker();

  @action
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
  }

  @observable
  String picture = '';

  @action
  Future<void> pickImage({required source, required context}) async {
    final image = await picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    picture = image.path;
    Navigator.of(context).pop();
  }

  @action
  void clearAll() {
    fullnameController.clear();
    numberController.clear();
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    locationController.clear();
    picture = '';
  }

  @observable
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
