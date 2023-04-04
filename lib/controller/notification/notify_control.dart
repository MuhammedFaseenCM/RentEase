import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/const_colors.dart';

class NotifyController extends GetxController {
  final reqQuery = FirebaseFirestore.instance.collection("SendReq");
  final resQuery = FirebaseFirestore.instance.collection("SendRes");
  late Stream<QuerySnapshot<Object?>> reqStream;
  late Stream<QuerySnapshot<Object?>> resStream;

  List<Map<String, dynamic>> items = [];
  int itemsLength = 0;
  NotifyController() {
    reqStream = reqQuery.snapshots();
    resStream = resQuery.snapshots();
  }

  Future<void> deleteNotify({required docId, required Map map}) async {
    final docName =
        "${FirebaseAuth.instance.currentUser!.email.toString()}_${map['title']}";
    await reqQuery.doc(docName).update({'status': 'reject'});
    final docUser = resQuery.doc(docName);
    docUser.set({
      'ownerEmail': FirebaseAuth.instance.currentUser!.email.toString(),
      'userEmail': map['userEmail'],
      'title': map['title'],
      'image1': map['image1'],
      'plan': map['price'],
      'status': 'reject'
    });
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

  Future<void> acceptNotify(
      {required title,
      required email,
      required image1,
      required price,
      required docId}) async {
    final docUser = resQuery.doc(docId);
    final reqUser = reqQuery.doc(docId);
    reqUser.update({'status': 'accept'});
    docUser.set({
      'ownerEmail': FirebaseAuth.instance.currentUser!.email.toString(),
      'userEmail': email,
      'title': title,
      'image1': image1,
      'plan': price,
      'status': 'accept',
      'payment': 'waiting'
    });
  }

  bool notify = true;

  get notfyIconController => notify;
  set notfyIconController(value) {
    notify = value;
  }
}
