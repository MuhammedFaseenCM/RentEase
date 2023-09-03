import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/loginpage/login_controller.dart';
import 'package:rentease/view/signuppage/signup_controller.dart';

class TextFieldWidget extends GetView<SignupController> {
  final String hintText;
  final TextEditingController editingController;
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
  final dynamic prefixIcon;
  final Function(String value)? validator;
   TextFieldWidget({
    super.key,
    required this.hintText,
    required this.editingController,
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
      child: _textFormField(),
    );
  }

  GetBuilder<GetxController> _textFormField() {
    return GetBuilder(
      builder: (context) {
        return TextFormField(
          controller: editingController,
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
              prefixIcon: isEmail
                  ? const Icon(
                      Icons.mail,
                    )
                  : prefixIcon,
              suffixIcon: suffixIcon
                  ? IconButton(
                      onPressed: () {
                      },
                      icon: controller.passwordVisible 
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    )
                  : null),
        );
      }
    );
  }
}
