import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUser {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final List<Map<String,dynamic>>? addresses;
  final String? idImage;
  CreateUser({
    required this.name,
    required this.email,
    required this.password,
    this.addresses,
    required this.phoneNumber,
    this.idImage,
  });

  factory CreateUser.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;

    return CreateUser(
      name: data['name'],
      email: data['email'],
      password: data['password'],
        addresses: data['addresses'],
      phoneNumber: data['phoneNumber'],
      //  idImage: data['idImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
        'addresses':addresses,
      'phoneNumber': phoneNumber,
       'idImage':idImage
    };
  }
}
