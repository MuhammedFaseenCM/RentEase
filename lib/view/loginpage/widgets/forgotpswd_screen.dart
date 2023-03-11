import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/loginmodel/login_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/controller/signin/forgot_function.dart';

GlobalKey formKey2 = GlobalKey<FormState>();

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  static LoginModel loginmodel = Get.put(LoginModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: "Forgot passowrd"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: formKey2,
              child: Column(
                children: [
                  const Text(
                    "Enter an email to reset your password",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  kheight20,
                  TextFieldWidget(
                    hintText: "Email",
                    controller: loginmodel.emailController,
                    isEmail: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  kheight20,
                  ButtonWidget(
                    text: "Reset password",
                    onpressed: (context) {
                      resetPassword(
                          email: loginmodel.emailController.text.trim(),
                          context: context);
                    },
                    color: Colors.blueGrey,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
