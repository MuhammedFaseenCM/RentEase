import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String title;
  final num? rating;
  final String userEmail;
  final String ownerEmail;
  final String? review;
  final String? userName;

  ReviewModel(
      {required this.title,
      required this.ownerEmail,
      this.rating,
      this.review,
      this.userName,
      required this.userEmail});

  Map<String, dynamic> reviewToMap() {
    if (rating == null) {
      return {
        'title': title,
        'userEmail': userEmail,
        'ownerEmail': ownerEmail,
        'review': review,
        'userName': userName
      };
    } else if (review == null) {
      return {
        'title': title,
        'userEmail': userEmail,
        'ownerEmail': ownerEmail,
        'rating': rating,
      };
    } else {
      return {
        'title': title,
        'userEmail': userEmail,
        'ownerEmail': ownerEmail,
        'rating': rating,
        'review': review,
        'userName': userName
      };
    }
  }

  factory ReviewModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return ReviewModel(
        title: data['title'],
        userEmail: data['userEmail'],
        rating: data['rating'],
        review: data['review'],
        ownerEmail: data['ownerEmail'],
        userName: data['userName']);
  }
}
