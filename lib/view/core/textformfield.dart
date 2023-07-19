import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/loginmodel/mobx/login_mobx.dart';
import 'package:rentease/model/signupmodel/mobx/signup_model.dart';
import 'package:rentease/view/core/string_consts.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double? radiusleft;
  final double? radiusRight;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool suffixIcon;
  final bool isEmail;
  final bool isPswd;
  final IconData? icon;
  final dynamic? prefixIcon;
  final Function(String value)? validator;
   TextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.radiusleft,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.radiusRight,
    this.keyboardType = TextInputType.name,
    this.obscureText = false,
    this.suffixIcon = false,
    this.isEmail = false,
    this.isPswd = false,
    this.icon,
    this.prefixIcon,
    this.validator,
  });
  static final SignUpModel signupmodel = Get.put(SignUpModel());
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(225, 95, 27, 3).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(-15, 15),
          ),
          BoxShadow(
            color: const Color.fromRGBO(225, 95, 27, 3).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(15, 15),
          ),
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusleft ?? 20.0),
            topRight: Radius.circular(radiusRight ?? 20.0),
            bottomLeft: Radius.circular(radiusBottomLeft ?? 20.0),
            bottomRight: Radius.circular(radiusBottomRight ?? 20.0)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: isEmail
            ? (value) {
                if (isEmail) {
                  if (value != null && !EmailValidator.validate(value)) {
                    return validEmailText;
                  } else {
                    return null;
                  }
                }
                return null;
              }
            : ((value) => validator!(value!)),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            //   hintStyle: TextStyle(color: Colors.white54),
            prefixIcon: isEmail
                ? const Icon(
                    Icons.mail,
                  )
                : prefixIcon,
            // fillColor: Colors.white,
            suffixIcon: suffixIcon
                ? IconButton(
                    //color: Colors.white,
                    onPressed: () {
                      // loginmodel.passwordVisible = !loginmodel.passwordVisible;
                      // signupmodel.passwordVisible =
                      //     !signupmodel.passwordVisible;
                    },
                    icon: signupmodel.passwordVisible 
                    //||
                           // loginmodel.passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null),
      ),
    );
  }
}
