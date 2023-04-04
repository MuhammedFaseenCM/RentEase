import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rentease/model/signupmodel/mobx/signup_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';

class OtpScreen extends StatelessWidget {
  final String number;
  final int otp;
  const OtpScreen({super.key, required this.number, required this.otp});
  static final SignUpModel signupmodel = SignUpModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBarWidget(title: appName)),
        body: CustomContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kheight20,
            const Text(
              "Verification",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            kheight10,
            Text(
              "We have sent the code verification to ${maskPhoneNumber(number)}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            kheight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                OtpBox(),
                kwidth10,
                OtpBox(),
                kwidth10,
                OtpBox(),
                kwidth10,
                OtpBox(),
                kwidth10,
                OtpBox(),
                kwidth10,
                OtpBox(),
              ],
            ),
            kheight20,
            Observer(builder: (context) {
              return ButtonWidget(
                text: "Submit",
                onpressed: (context) {
                  if (otp.toString() == signupmodel.codeController.text) {
                    log("same");
                  } else {
                    log("different");
                    signupmodel.codeController.text = '';
                  }
                },
              );
            })
          ],
        )));
  }

  String maskPhoneNumber(String phoneNumber) {
    final maskedNumber =
        '${phoneNumber.substring(5, 9)}${'*' * 6}${phoneNumber.substring(8)}';
    return maskedNumber;
  }
}

class OtpBox extends StatelessWidget {
  const OtpBox({super.key});
  static final SignUpModel signupmodel = SignUpModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kwhiteColor,
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 1.0, spreadRadius: 1.0)
          ],
          borderRadius: BorderRadius.circular(8.0)),
      height: 50,
      width: 46,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
            signupmodel.codeController.text =
                signupmodel.codeController.text + value;
            log(signupmodel.codeController.text);
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
            signupmodel.codeController.text = signupmodel.codeController.text
                .substring(0, signupmodel.codeController.text.length - 1);
            log(signupmodel.codeController.text);
          }
        },
        onSaved: (pin) {},
        decoration: const InputDecoration(border: InputBorder.none),
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
