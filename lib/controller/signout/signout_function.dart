import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentease/main.dart';

Future<void> signOutFunc({required context}) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  FirebaseAuth.instance.signOut();
  googleSignIn.signOut();
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
