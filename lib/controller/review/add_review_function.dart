import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/addressmodel/edit_mobx.dart/edit_address_getx.dart';
import 'package:rentease/model/ordermodel/order_model.dart';
import 'package:rentease/model/reviewratingmodel/review_model.dart';
import 'package:rentease/view/core/const_colors.dart';

Future<void> addReview(
    {required String title,
    required TextEditingController reviewController,
    required String ownerEmail}) async {
  OrderModel orderModel = OrderModel();
  ProfileControl profileControl = ProfileControl();
  final snapshot = profileControl.docRef
      .doc(FirebaseAuth.instance.currentUser!.email.toString());
  Map? data;
  var docsnapshot = await snapshot.get();

  if (docsnapshot.exists) {
    data = docsnapshot.data();
  }
  if (data == null) {
    Get.snackbar("Please update your profile details", "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kredColor,
        colorText: kwhiteColor);
    return;
  }
  Get.dialog(
    const Center(
      child: CircularProgressIndicator(),
    ),
  );
  final reviewRatingDoc = orderModel.collection
      .doc("${FirebaseAuth.instance.currentUser!.email.toString()}_$title");
  final newreview = ReviewModel(
          title: title,
          ownerEmail: ownerEmail,
          review: reviewController.text,
          userEmail: FirebaseAuth.instance.currentUser!.email.toString(),
          userName: data['name'])
      .reviewToMap();
  await reviewRatingDoc.get().then((snapshot) {
    if (snapshot.exists) {
      reviewRatingDoc.update(newreview).catchError((error) {
        print(error);
      });
    } else {
      reviewRatingDoc.set(newreview);
    }
  });

  Get.back();
  Get.back();

  Get.snackbar(
    "Thanks for your valuable time",
    "",
    snackPosition: SnackPosition.BOTTOM,
  );
  reviewController.clear();
}
