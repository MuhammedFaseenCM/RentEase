import 'package:flutter/material.dart';
import 'package:rentease/model/loginmodel/mobx/login_mobx.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/controller/signin/login_functions.dart';
import 'package:rentease/controller/signin/signin_google.dart';
import 'package:rentease/view/loginpage/widgets/fields.dart/email_field.dart';
import 'package:rentease/view/loginpage/widgets/fields.dart/password_field.dart';
import 'package:rentease/view/loginpage/widgets/forgotpswd_screen.dart';
import 'package:rentease/view/loginpage/widgets/google_widget.dart';
import 'package:rentease/view/signuppage/signup_screen.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({super.key});
  static final loginFormKey = GlobalKey<FormState>();
  static final LoginModel loginModel = LoginModel();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: kwhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            topRight: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EmailField(emailController: loginModel.emailController),
                kheight20,
                PasswordField(
                  passwordController: loginModel.passwordController,
                ),
                kheight20,
                kheight20,
                InkWell(
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
                    )),
                kheight20,
                ButtonWidget(
                  text: logintext,
                  onpressed: (context) {
                    final isValid = loginFormKey.currentState!.validate();
                    if (!isValid) return;
                    signIn(
                        context: context,
                        email: loginModel.emailController,
                        password: loginModel.passwordController);
                  },
                ),
                kheight20,
                const Text(signinWithText),
                kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          siginInWithGoogle(context: context);
                        },
                        child: const SignInContainer())
                  ],
                ),
                kheight20,
                const Text(noAccountText),
                ButtonWidget(
                  text: signUpText,
                  onpressed: (context) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
