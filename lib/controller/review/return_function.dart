import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/const_colors.dart';

Future<void> returnGadget(
    {required BuildContext context,
    required DocumentSnapshot<Object?> docSnapshot}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    await docSnapshot.reference
        .update({'available': 'true'}).then((value) => Get.back());
    Get.snackbar(
      "Return info sent to owner ",
      "",
      backgroundColor: kgreenColor,
      colorText: kwhiteColor,
    );
  } catch (e) {
    print("Error updating document: $e");
  }
  Get.back();
}
