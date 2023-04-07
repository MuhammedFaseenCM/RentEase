import 'package:cloud_firestore/cloud_firestore.dart';

class SendAcceptModel {
  final String title;
  final String userEmail;
  final String status;
  final String plan;
  final String payment;
  final String ownerEmail;
  final String image1;
  SendAcceptModel(
      {required this.title,
      required this.userEmail,
      required this.image1,
      required this.ownerEmail,
      required this.payment,
      required this.plan,
      required this.status});

  Map<String, dynamic> acceptToMap() {
    return {
      'title': title,
      'userEmail': userEmail,
      'image1': image1,
      'ownerEmail': ownerEmail,
      'status': status,
      'plan': plan,
      'payment': payment,
    };
  }

  factory SendAcceptModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return SendAcceptModel(
        title: data['title'],
        userEmail: data['userEmail'],
        image1: data['image1'],
        ownerEmail: data['ownerEmail'],
        payment: data['payment'],
        plan: data['plan'],
        status: data['status']);
  }
}
