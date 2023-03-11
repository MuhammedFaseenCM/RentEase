import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease/view/core/utils.dart';

Future resetPassword({required email, required context}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    Utils.showSnackBar("Password reset Email sent", color: Colors.green);
    Navigator.of(context).popUntil((route) => route.isFirst);
  } on FirebaseAuthException catch (e) {
    Utils.showSnackBar(e.message);
    Navigator.of(context).pop();
  }
}
