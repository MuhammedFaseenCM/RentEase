import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentease/view/core/const_colors.dart';

class RatingWidget extends StatelessWidget {
  final String ownerEmail;
  final String title;
  const RatingWidget(
      {super.key, required this.ownerEmail, required this.title});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Review&Rating")
          .where('ownerEmail', isEqualTo: ownerEmail)
          .where('title', isEqualTo: title)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          QuerySnapshot? querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot>? documents = querySnapshot!.docs;
          List<double>? fetchedRatings =
              documents.map((doc) => doc['rating'] as double).toList();
          if (fetchedRatings.isEmpty) {
            return Row(
              children: const [
                Text(
                  "0.0",
                  style: TextStyle(color: kblackColor),
                ),
                Icon(
                  FontAwesomeIcons.solidStar,
                  size: 15.0,
                  color: Colors.orangeAccent,
                )
              ],
            );
          } else {
            return Row(
              children: [
                Text(
                  fetchedRatings[0].toString(),
                  style: const TextStyle(color: kblackColor),
                ),
                const Icon(
                  FontAwesomeIcons.solidStar,
                  size: 15.0,
                  color: Colors.orangeAccent,
                )
              ],
            );
          }
        } else if (snapshot.hasError) {
          return Row(
            children: const [
              Text(
                '0.0',
                style: TextStyle(color: kblackColor),
              ),
              Icon(
                FontAwesomeIcons.solidStar,
                size: 15.0,
                color: Colors.orangeAccent,
              )
            ],
          );
        } else {
          return Row(
            children: const [
              Text(
                "0.0",
                style: TextStyle(color: kblackColor),
              ),
              Icon(
                FontAwesomeIcons.solidStar,
                size: 15.0,
                color: Colors.orangeAccent,
              )
            ],
          );
        }
      },
    );
  }
}
