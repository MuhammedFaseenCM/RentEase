import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/ordermodel/order_model.dart';
import 'package:rentease/model/reviewratingmodel/review_model.dart';

Future<void> addReview(
    {required String title,
    required TextEditingController reviewController,
    required String ownerEmail}) async {
  OrderModel orderModel = OrderModel();
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
  ).reviewToMap();
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
