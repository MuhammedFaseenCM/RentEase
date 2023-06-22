import 'package:cloud_firestore/cloud_firestore.dart';

class SendRequestModel {
  final String title;
  final String userName;
  final String plan;
  final String price;
  final String userEmail;
  final String ownerEmail;
  final String phoneNumber;
  final String image1;
  final String status;
  final Map<String, dynamic> address;
  SendRequestModel({
    required this.title,
    required this.userName,
    required this.plan,
    required this.price,
    required this.userEmail,
    required this.ownerEmail,
    required this.phoneNumber,
    required this.address,
    required this.image1,
    required this.status,
  });

  Map<String, dynamic> addressToMap() {
    return {
      'title': title,
      'plan': plan,
      'price': price,
      'userEmail': userEmail,
      'ownerEmail': ownerEmail,
      'phoneNumber': phoneNumber,
      'address': address,
      'image1': image1,
      'status':status,
      'userName': userName
    };
  }

  factory SendRequestModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return SendRequestModel(
        title: data['title'],
        plan: data['plan'],
        price: data['price'],
        userEmail: data['userEmail'],
        ownerEmail: data['ownerEmail'],
        phoneNumber: data['phoneNumber'],
        address: data['address'],
        image1: data['image1'],
        status: data['status'],
        userName: data['userName']);
  }
}
