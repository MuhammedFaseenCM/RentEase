import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_mobx.g.dart';

class LoginModel = _LoginModel with _$LoginModel;

abstract class _LoginModel with Store {

   @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  bool obscureText = true;

  @action
  void toggleObscureText() {
    obscureText = !obscureText;
  }
}
