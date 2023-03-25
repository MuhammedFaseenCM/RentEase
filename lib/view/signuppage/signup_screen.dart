import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/signupmodel/signup_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/signuppage/widget/signup_screentwo.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static final SignUpModel signupmodel = Get.put(SignUpModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: signupText)),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: boxDecoration,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: signupmodel.signupformKey,
              child: Column(
                children: [
                  kheight20,
                  TextFieldWidget(
                    hintText: fullnameText,
                    controller: signupmodel.fullnameController,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value.isEmpty) {
                        return validNameText;
                      }
                    },
                  ),
                  kheight20,
                  TextFieldWidget(
                    hintText: numberText,
                    controller: signupmodel.numberController,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.phone,
                    validator: (value) {
                      if (value.isEmpty || value.length != 10) {
                        return validNumberText;
                      }
                    },
                  ),
                  kheight20,
                  TextFieldWidget(
                    hintText: mailText,
                    controller: signupmodel.emailController,
                    keyboardType: TextInputType.emailAddress,
                    isEmail: true,
                  ),
                  kheight20,
                  TextFieldWidget(
                    hintText: passwordText,
                    controller: signupmodel.passwordController,
                    obscureText: !signupmodel.passwordVisible,
                    prefixIcon: Icons.lock,
                    suffixIcon: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return validPassowrdText;
                      } else if (value.length < 6) {
                        return validPassowrdText;
                      }
                    },
                  ),
                  kheight20,
                  TextFieldWidget(
                    hintText: confirmPassText,
                    controller: signupmodel.confirmpasswordController,
                    obscureText: !signupmodel.passwordVisible,
                    suffixIcon: true,
                    prefixIcon: Icons.lock,
                    validator: (value) {
                      if (value.isEmpty) {
                        return validPassowrdText;
                      } else if (value != signupmodel.passwordController.text) {
                        return validMatchPassText;
                      }
                    },
                  ),
                  kheight20,
                  ButtonWidget(
                    text: nextText,
                    color: Colors.grey[800],
                    onpressed: (context) {
                      final isValid =
                          signupmodel.signupformKey.currentState!.validate();
                      if (!isValid) return;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpSecondScreen(
                          password: signupmodel.passwordController.text.trim(),
                          email: signupmodel.emailController.text.trim(),
                        ),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpTextFieldWidget extends StatelessWidget {
  final String hintText;
  const SignUpTextFieldWidget({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(), hintText: hintText),
    );
  }
}
