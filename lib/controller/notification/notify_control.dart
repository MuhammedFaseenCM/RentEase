import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentease/model/acceptmodel/accept_model.dart';
import 'package:rentease/model/addressmodel/edit_mobx.dart/edit_address_getx.dart';
import 'package:rentease/model/requestmodel/sendreqmodel.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class NotifyController extends GetxController {
  final reqQuery = FirebaseFirestore.instance.collection("SendReq");
  final resQuery = FirebaseFirestore.instance.collection("SendRes");
  late Stream<QuerySnapshot<Object?>> reqStream;
  late Stream<QuerySnapshot<Object?>> resStream;

  
  int itemsLength = 0;
  NotifyController() {
    reqStream = reqQuery.snapshots();
    resStream = resQuery.snapshots();
  }
  ProfileControl profileControl = ProfileControl();
  Future<void> sendResp(
      {required docId,
      required SendRequestModel sendReq,
      bool accept = true,
      required String status}) async {
    final snapshot = profileControl.docRef
        .doc(FirebaseAuth.instance.currentUser!.email.toString());
    Map? data;
    var docsnapshot = await snapshot.get();

    if (docsnapshot.exists) {
      data = docsnapshot.data();
    }
    if (data == null) {
      Get.snackbar(wrongText, "");
      return;
    }
    final docName =
        "${FirebaseAuth.instance.currentUser!.email.toString()}_${sendReq.title}";
    final docUser = resQuery.doc(docName);
    final sendResponse = SendAcceptModel(
            title: sendReq.title,
            userEmail: sendReq.userEmail,
            image1: sendReq.image1,
            ownerEmail: sendReq.ownerEmail,
            payment: "Waiting",
            plan: sendReq.price,
            status: status,
            ownerName: data['name'],
            userName: sendReq.userName)
        .acceptToMap();
    docUser.set(sendResponse);
    if (accept == true) {
      await reqQuery.doc(docName).update({'status': 'accept'});
    } else {
      await reqQuery.doc(docName).update({'status': 'reject'});
    }
  }

  Future<void> deleteRes({required docId}) async {
    await resQuery.doc(docId).delete();
    final reqUser = reqQuery.doc(docId);
    reqUser.update({'status': 'reject'});
    Get.snackbar("Deleted", "",
        backgroundColor: kgreenColor,
        snackPosition: SnackPosition.BOTTOM,
        colorText: kwhiteColor);
  }

  bool notify = true;

  get notfyIconController => notify;
  set notfyIconController(value) {
    notify = value;
  }
}
