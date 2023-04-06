import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileControl extends GetxController {
  final docRef = FirebaseFirestore.instance.collection("Users");
  Future<String> addressDetails({required key,required index}) async {
    final userDoc =
        docRef.doc(FirebaseAuth.instance.currentUser!.email.toString());
    final getDoc = await userDoc.get();
    final map = getDoc.data();
    return map![index][key];
  }


    TextEditingController houseNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  


}
