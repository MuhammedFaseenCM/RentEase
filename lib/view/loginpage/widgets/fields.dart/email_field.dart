import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentease/model/loginmodel/mobx/login_mobx.dart';
import 'package:rentease/view/core/string_consts.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({super.key, required this.emailController});
  static final LoginModel loginModel = LoginModel();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        label: Text(mailText),
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          FontAwesomeIcons.envelope,
          size: 20.0,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value != null && !EmailValidator.validate(value)) {
          return validEmailText;
        } else {
          return null;
        }
      },
    );
  }
}
