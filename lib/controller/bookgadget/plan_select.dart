import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/fetch_profile_details.dart';
import 'package:rentease/model/homemodel/gadgets.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class SelectPlan extends GetxController {
  ProfileControl profileControl = ProfileControl();
  Future<void> sendReq(
      {required Gadgets gadget,
      required planType,
      required price,
      required doc}) async {
    final snapshot = profileControl.docRef
        .doc(FirebaseAuth.instance.currentUser!.email.toString());
    Map? data;
    var docsnapshot = await snapshot.get();

    if (docsnapshot.exists) {
      data = docsnapshot.data();
    }
    if (data == null) {
      Get.snackbar("You are location is not available", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kredColor,
          colorText: kwhiteColor);
      return;
    }
    final docName =
        "${FirebaseAuth.instance.currentUser!.email.toString()}_${gadget.title}";
    final docUser =
        FirebaseFirestore.instance.collection("SendReq").doc(docName);

    docUser.set({
      'ownerEmail': gadget.email,
      'userEmail': FirebaseAuth.instance.currentUser!.email.toString(),
      'title': gadget.title,
      'image1': gadget.image1,
      'plan': planType,
      'price': price,
      'location': data['location'],
      'status': 'waiting',
      'idImage': data['idImage'],
      'phoneNumber': data['phoneNumber']
    });
    final docItem = FirebaseFirestore.instance.collection("RentEase").doc(doc);

    docItem.update({'available': 'false'});
  }
}
