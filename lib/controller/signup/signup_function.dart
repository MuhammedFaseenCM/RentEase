import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/signupmodel/signup_model.dart';
import 'package:rentease/view/core/const_colors.dart';
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
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((userCredential) => {userSignupDetailsToFireStore()});
  } on FirebaseAuthException catch (e) {
    Utils.showSnackBar(
      e.message,
      color: Colors.red[900],
      textColor: kwhiteColor,
    );
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}

Future<void> userSignupDetailsToFireStore() async {
  Get.dialog(
    const Center(
      child: CircularProgressIndicator(),
    ),
  );

  final SignUpModel signupmodel = Get.put(SignUpModel());
  final metaData = SettableMetadata(contentType: 'image/jpeg');
  final storageRef = FirebaseStorage.instance.ref("userIDs");
  Reference ref =
      storageRef.child("${signupmodel.emailController.text.trim()}.jpg");
  final uploadTask = ref.putFile(File(signupmodel.picture.value), metaData);
  final taskSnapshot = await uploadTask.whenComplete(() => null);
  String url = await taskSnapshot.ref.getDownloadURL();

  final docUser = FirebaseFirestore.instance
      .collection("Users")
      .doc(signupmodel.emailController.text.trim());

  Map<String, String> userDataToSend = {
    'name': signupmodel.fullnameController.text.trim(),
    'phoneNumber': signupmodel.numberController.text.trim(),
    'email': signupmodel.emailController.text.trim(),
    'password': signupmodel.passwordController.text.trim(),
    'location': signupmodel.locationController.text.trim(),
    'idImage': url
  };
  await docUser.set(userDataToSend);
  signupmodel.clearAll();
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
