import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String title;
  final String ownerEmail;
  final String userEmail;
  final String payment;
  final String image1;

  final String status;
  final String plan;

  Booking({
    required this.title,
    required this.image1,
    required this.ownerEmail,
    required this.userEmail,
    required this.payment,
    required this.status,
    required this.plan,
  });

  factory Booking.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return Booking(
      title: data['title'],
      ownerEmail: data['ownerEmail'],
      image1: data['image1'],
      userEmail: data['userEmail'],
      plan: data['plan'],
      payment: data['payment'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'ownerEmail': ownerEmail,
      'userEmail': userEmail,
      'image1': image1,
      'payment': payment,
      'plan': plan,
      'status': status,
    };
  }
}
