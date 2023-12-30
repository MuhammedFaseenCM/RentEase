import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/paidmodel/paidgadgetmodel.dart';
import 'package:rentease/model/reviewratingmodel/review_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/homepage/orders/order_controller.dart';
import 'package:rentease/view/homepage/profile/profile_controller.dart';

class ReviewController extends GetxController {
  late MyOrderModel order;

  TextEditingController reviewController = TextEditingController();

  final collection = FirebaseFirestore.instance.collection("Review&Rating");

  Future<void> addReview({
    required String title,
    required TextEditingController reviewController,
    required String ownerEmail,
  }) async {
    final snapshot = Get.find<ProfileController>()
        .docRef
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
    final reviewRatingDoc = collection
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

  @override
  void onInit() {
    super.onInit();
    order = Get.find<OrderController>().order;
  }
}
