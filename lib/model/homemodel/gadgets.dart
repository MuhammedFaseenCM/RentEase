import 'package:cloud_firestore/cloud_firestore.dart';

class Gadgets {
  final String title;
  final String email;
  final String category;
  final String details;
  final String image1;
  final String image2;
  final String image3;
  final String dayPrice;
  final String weekPrice;
  final String monthPrice;
  final String available;
  final Map<String, dynamic> address;
  final String houseNo;
  final String area;
  final String city;
  final String pincode;
  final String state;

  Gadgets({
    required this.title,
    required this.email,
    required this.category,
    required this.details,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.dayPrice,
    required this.weekPrice,
    required this.monthPrice,
    required this.available,
    required this.address,
    required this.houseNo,
    required this.area,
    required this.city,
    required this.pincode,
    required this.state,
  });

  factory Gadgets.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return Gadgets(
        title: data['title'],
        email: data['email'],
        category: data['category'],
        details: data['details'],
        image1: data['image1'],
        image2: data['image2'],
        image3: data['image3'],
        dayPrice: data['dayPrice'],
        weekPrice: data['weekPrice'],
        monthPrice: data['monthPrice'],
        available: data['available'],
        address: data['address'],
        houseNo: data['address']['houseNo'],
        area: data['address']['area'],
        city: data['address']['city'],
        pincode: data['address']['pincode'],
        state: data['address']['state']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'email': email,
      'category': category,
      'details': details,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'dayPrice': dayPrice,
      'weekPrice': weekPrice,
      'monthPrice': monthPrice,
      'available': available,
      'address': {
        'houseNo': houseNo,
        'area': area,
        'city': city,
        'pincode': pincode,
        'state': state
      }
    };
  }
}
