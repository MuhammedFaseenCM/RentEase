import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentease/controller/signup/signup_function.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/utils.dart';

siginInWithGoogle({
  required context,
}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    final signin = await auth.signInWithCredential(credential).then((value) => userSignupDetailsToFireStore(
      
      name: googleSignInAccount.displayName, email: googleSignInAccount.email, phoneNumber: "", password: ""));
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    return signin;
  } on Exception catch (e) {
    Utils.showSnackBar(e.toString());
  }
}
