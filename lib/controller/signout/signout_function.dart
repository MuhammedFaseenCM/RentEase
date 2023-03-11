import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/loginpage/widgets/login_page_widget.dart';

Future<void> signOutFunc({required context, required googleSignIn}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  FirebaseAuth.instance.signOut();
  googleSignIn.signOut();
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) {
        return const LoginPage();
      },
    ),
  );
}
