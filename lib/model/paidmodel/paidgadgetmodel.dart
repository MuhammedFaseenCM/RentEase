import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrderModel {
  final String title;
  final String plan;
  final String payment;
  final String ownerEmail;
  final String userEmail;
  final String image1;

  MyOrderModel(
      {required this.title,
      required this.plan,
      required this.payment,
      required this.image1,
      required this.ownerEmail,
      required this.userEmail});

  Map<String, dynamic> acceptToMap() {
    return {
      'title': title,
      'userEmail': userEmail,
      'image1': image1,
      'ownerEmail': ownerEmail,
      'plan': plan,
      'payment': payment,
    };
  }

  factory MyOrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return MyOrderModel(
      title: data['title'],
      userEmail: data['userEmail'],
      image1: data['image1'],
      ownerEmail: data['ownerEmail'],
      payment: data['payment'],
      plan: data['plan'],
    );
  }
}
