import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? stream = FirebaseFirestore
      .instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .snapshots();
}
