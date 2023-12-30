import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/paidmodel/paidgadgetmodel.dart';
import 'package:rentease/view/core/const_colors.dart';

class OrderController extends GetxController {
  double rating = 0;

  final collection = FirebaseFirestore.instance.collection("Review&Rating");

  static const String reBuildRating = "reBuildRating";

  late MyOrderModel order;

  Stream orderStream = FirebaseFirestore.instance
      .collection("PaidGadgets")
      .where('userEmail',
          isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
      .snapshots();

  void setRating(double value) {
    rating = value;
  }

  List<double> ratings = [];

  Future<void> fetchRatings({required ownerEmail, required title}) async {
    final ratingRef = FirebaseFirestore.instance.collection("Review&Rating");

    QuerySnapshot ratingQuerySnapshot = await ratingRef
        .where('OwnerEmail', isEqualTo: ownerEmail)
        .where('title', isEqualTo: title)
        .get();

    List<double> fetchedRatings =
        ratingQuerySnapshot.docs.map((doc) => doc['rating'] as double).toList();

    ratings.addAll(fetchedRatings);
  }

  Future<void> addRating({
    required value,
  }) async {
    final reviewRatingDoc = collection.doc(
        "${FirebaseAuth.instance.currentUser!.email.toString()}_${order.title}");

    reviewRatingDoc.get().then(
      (snapshot) {
        if (snapshot.exists) {
          reviewRatingDoc.update(
            {
              'rating': value,
              'ownerEmail': order.ownerEmail,
              'title': order.title
            },
          ).catchError(
            (error) {
              print(error);
            },
          );
        } else {
          reviewRatingDoc.set(
            {
              'rating': value,
              'ownerEmail': order.ownerEmail,
              'title': order.title
            },
          );
        }
      },
    );

    Get.snackbar(
      "Thanks for the rating",
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kgreenColor,
      colorText: kwhiteColor,
    );

    update([reBuildRating]);
  }

  Future<void> returnGadget({
    required BuildContext context,
    required DocumentSnapshot<Object?> docSnapshot,
  }) async {
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

    update([reBuildRating]);
  }
}
