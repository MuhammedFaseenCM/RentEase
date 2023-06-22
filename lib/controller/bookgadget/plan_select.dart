import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/fetch_profile_details.dart';
import 'package:rentease/model/homemodel/gadgets.dart';
import 'package:rentease/model/requestmodel/sendreqmodel.dart';
import 'package:rentease/view/core/const_colors.dart';

class SelectPlan extends GetxController {
  ProfileControl profileControl = ProfileControl();
  final docRef = FirebaseFirestore.instance.collection("Users");

  Future<void> sendReq(
      {required Gadgets gadget,
      required address,
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
      Get.snackbar("Please update your profile details", "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kredColor,
          colorText: kwhiteColor);
      return;
    }
    final docName = "${gadget.email}_${gadget.title}";
    final docUser =
        FirebaseFirestore.instance.collection("SendReq").doc(docName);
    final sendReqModel = SendRequestModel(
            title: gadget.title,
            userName: data['name'],
            plan: planType,
            price: price,
            userEmail: FirebaseAuth.instance.currentUser!.email.toString(),
            ownerEmail: gadget.email,
            phoneNumber: data['phoneNumber'],
            address: address,
            image1: gadget.image1,
            status: 'waiting')
        .addressToMap();

    docUser.set(sendReqModel);
    final docItem = FirebaseFirestore.instance.collection("RentEase").doc(doc);

    docItem.update({'available': 'false'});
  }
}
