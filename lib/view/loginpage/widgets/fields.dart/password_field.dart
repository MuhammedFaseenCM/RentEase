import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentease/model/loginmodel/mobx/login_mobx.dart';
import 'package:rentease/view/core/string_consts.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController? confirmPassword;
  final bool? isConfirm;
  const PasswordField(
      {super.key,
      required this.passwordController,
      this.isConfirm = false,
      this.confirmPassword});
  static final LoginModel loginModel = LoginModel();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
            label:isConfirm!? const Text(confirmPassText):const Text(passwordText),
            border: const OutlineInputBorder(),
            suffixIcon: GestureDetector(
                onTap: loginModel.toggleObscureText,
                child: loginModel.obscureText
                    ? const Icon(
                        Icons.visibility_off,
                      )
                    : const Icon(Icons.visibility)),
            prefixIcon: const Icon(
              FontAwesomeIcons.lock,
              size: 20.0,
            )),
        obscureText: loginModel.obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validPassowrdText;
          }
          if (isConfirm == true && confirmPassword!.text != value) {
            return validMatchPassText;
          }
          return null;
        },
      );
    });
  }
}
