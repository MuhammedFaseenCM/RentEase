import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/const_colors.dart';

Future signIn({required context, required email, required password}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Get.snackbar(
      "Signed in as $email",
      "",
      backgroundColor: kgreenColor,
      colorText: kwhiteColor,
    );
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
