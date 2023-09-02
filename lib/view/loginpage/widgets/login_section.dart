import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rentease/services/routes/route_names.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/controller/signin/login_functions.dart';
import 'package:rentease/controller/signin/signin_google.dart';
import 'package:rentease/view/loginpage/login_controller.dart';
import 'package:rentease/view/loginpage/widgets/fields.dart/password_field.dart';
import 'package:rentease/view/loginpage/widgets/forgotpswd_screen.dart';
import 'package:rentease/view/loginpage/widgets/google_widget.dart';
import 'package:rentease/view/signuppage/signup_screen.dart';

class LoginSection extends GetView<LoginController> {
  const LoginSection({super.key});
  static final loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: _boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _emailField(),
                kheight20,
                PasswordField(
                  passwordController: controller.passwordController.value,
                ),
                kheight20,
                kheight20,
                _forgotButton(context),
                kheight20,
                _signInButton(),
                kheight20,
                const Text(signinWithText),
                kheight10,
                _googleButton(context),
                kheight20,
                const Text(noAccountText),
                _signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonWidget _signUpButton() {
    return ButtonWidget(
        text: signUpText,
        onpressed: (context) => Get.toNamed(RoutesName.signup));
  }

  Row _googleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              siginInWithGoogle(context: context);
            },
            child: const SignInContainer())
      ],
    );
  }

  ButtonWidget _signInButton() {
    return ButtonWidget(
      text: logintext,
      onpressed: (context) {
        final isValid = loginFormKey.currentState!.validate();
        if (!isValid) return;
        signIn(
            context: context,
            email: controller.emailController.value,
            password: controller.passwordController.value);
      },
    );
  }

  InkWell _forgotButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        ));
      },
      child: Text(
        forgotpassText,
        style: TextStyle(
            fontSize: 15.0,
            decorationColor: kBlue900,
            decoration: TextDecoration.underline),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
      color: kwhiteColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(60.0),
        topRight: Radius.circular(60.0),
      ),
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      controller: controller.emailController.value,
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
