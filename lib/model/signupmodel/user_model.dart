import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUser {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final String? location;
  final String? idImage;
  CreateUser({
    required this.name,
    required this.email,
    required this.password,
    this.location,
    required this.phoneNumber,
    this.idImage,
  });

  factory CreateUser.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;

    return CreateUser(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      //  location: data['location'],
      phoneNumber: data['phoneNumber'],
      //  idImage: data['idImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
        'location':location,
      'phoneNumber': phoneNumber,
       'idImage':idImage
    };
  }
}
