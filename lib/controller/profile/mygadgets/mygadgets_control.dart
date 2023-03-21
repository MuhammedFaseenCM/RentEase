import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/const_colors.dart';

class MyGadgetsController extends GetxController {
  final query = FirebaseFirestore.instance.collection("RentEase");
  late Stream<QuerySnapshot<Object?>> stream;
  MyGadgetsController() {
    stream = query.snapshots();
  }

  deleteGadget({required doc}) {
    query.doc(doc).delete().whenComplete(() => Get.snackbar(
        "Your gadget deleted", "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kgreenColor,
        colorText: kwhiteColor));
  }
}
