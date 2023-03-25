import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/fetch_profile_details.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class SelectPlan extends GetxController {
  ProfileControl profileControl = ProfileControl();
  Future<void> sendReq(
      {required itemMap, required planType, required price}) async {
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
    final docUser = FirebaseFirestore.instance
        .collection("SendReq")
        .doc(itemMap[titleInMapText]);
    docUser.set({
      'ownerEmail': itemMap[emailInMapText],
      'userEmail': FirebaseAuth.instance.currentUser!.email.toString(),
      'title': itemMap[titleInMapText],
      'image1': itemMap[firstImageText],
      'plan': planType,
      'price': price,
      'location': data['location'],
      'status': 'waiting'
    });
  }
}
