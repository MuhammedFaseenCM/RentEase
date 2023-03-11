import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/utils.dart';

Future<void> signUp(
    {required context, required email, required password}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    Utils.showSnackBar(e.message);
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
