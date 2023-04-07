import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentease/model/reviewratingmodel/review_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/home/widget/rating_widget.dart';

class ReviewWidget extends StatelessWidget {
  final String ownerEmail;
  final String title;
  const ReviewWidget({
    super.key,
    required this.ownerEmail,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Review&Rating")
            .where('ownerEmail', isEqualTo: ownerEmail)
            .where('title', isEqualTo: title)
            .where('review', isNull: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot>? documents = querySnapshot!.docs;
            List<String>? fetchedReviews =
                documents.map((doc) => doc['review'] as String).toList();

            if (fetchedReviews.isEmpty) {
              return const Center(
                child: Text("No reviews"),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: fetchedReviews.length,
                itemBuilder: (context, index) {
                  final reviewModel =
                      ReviewModel.fromSnapshot(documents[index]);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey[300]!, width: 4.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                kwidth10,
                                Text(
                                  reviewModel.userEmail,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: kblackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            RatingWidget(
                              ownerEmail: ownerEmail,
                              title: title,
                              isReviewContainer: true,
                            )
                          ],
                        ),
                        kheight20,
                        Text(
                          fetchedReviews[index],
                          maxLines: 6,
                        ),
                        kheight20,
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("No reviews"),
            );
          } else {
            return const Center(
              child: Text("No reviews"),
            );
          }
        });
  }
}
