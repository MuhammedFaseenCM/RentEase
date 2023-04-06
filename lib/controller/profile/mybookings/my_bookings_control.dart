import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyBookingController extends GetxController {
  final query = FirebaseFirestore.instance.collection("SendRes");
  Future<List<String>> getDocumentIds() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await query
        .where('ownerEmail',
            isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    List<String> documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIds;
  }

  late Stream<QuerySnapshot<Object?>> stream;
  MyBookingController() {
    stream = query
        .where('email',
            isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
        .snapshots();
  }
}
