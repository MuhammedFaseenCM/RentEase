import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/const_colors.dart';

Future signIn(
    {required context,
    required TextEditingController email,
    required TextEditingController password}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim())
        .then((value) async => {
               Get.snackbar(
                "Signed in as ${email.text}",
                "",
                backgroundColor: kgreenColor,
                colorText: kwhiteColor,
              ),
              email.clear(),
              password.clear()
            });
  } on FirebaseAuthException catch (e) {
    Get.snackbar(
      e.toString(),
      "",
      backgroundColor: kredColor,
      colorText: kwhiteColor,
    );
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
