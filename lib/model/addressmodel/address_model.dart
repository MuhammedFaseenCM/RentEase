import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String houseNo;
  final String area;
  final String city;
  final String pinCode;
  final String state;
  AddressModel(
      {required this.houseNo,
      required this.area,
      required this.city,
      required this.pinCode,
      required this.state});

  Map<String, dynamic> addressToMap() {
    return {
      'houseNo': houseNo,
      'area': area,
      'city': city,
      'pincode': pinCode,
      'state': state
    };
  }

  factory AddressModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
        houseNo: data['address']['houseNo'],
        area: data['address']['area'],
        city: data['address']['city'],
        pinCode: data['address']['pincode'],
        state: data['address']['state']);
  }
}
