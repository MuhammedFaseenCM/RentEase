import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

String image1FromFile = '';
String image2FromFile = '';
String image3FromFile = '';

class UpdateController extends GetxController {
  ItemModel itemModel = ItemModel();
  final formKey = GlobalKey<FormState>();
  final docRef = FirebaseFirestore.instance.collection(appName);
  Future<Map<String, dynamic>?> itemMap({required doc}) async {
    final itemDoc = docRef.doc(doc);
    final getItemDoc = await itemDoc.get();
    return getItemDoc.data();
  }

  TextEditingController itemTitleController = TextEditingController();
  TextEditingController itemDetailController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController weekController = TextEditingController();
  TextEditingController monthController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  String image1Url = '';
  String image2Url = '';
  String image3Url = '';
  RxString firstImage = ''.obs;
  RxString secondImage = ''.obs;
  RxString thirdImage = ''.obs;

  void updateFirstImageValue(String value) {
    firstImage.value = value;
  }

  RxList<XFile> imageFileList = RxList<XFile>();

  Future<void> updateImage({required image}) async {
    final getImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 75);

    image.value = getImage!.path;
  }

  Future<String> uploadFile(File file) async {
    String uniqueFileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageRef = FirebaseStorage.instance.ref('images');
    Reference ref = storageRef.child(uniqueFileName);
    final uploadTask = ref.putFile(file, metaData);
    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<void> updateItem(
      {required doc,
      required title,
      required details,
      required dayPrice,
      required weekPrice,
      required monthPrice,
      required category,
      required selectedfirstImage,
      required selectedsecondImage,
      required selectedthirdImage}) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    ));
    final itemDoc = docRef.doc(doc);
    if (image2FromFile.isNotEmpty) {
      image2Url = await uploadFile(File(image2FromFile));
      await itemDoc.update({'image2': image2Url}).then((value) {
        image2FromFile = '';
      });
    }
    if (image1FromFile.isNotEmpty) {
      image1Url = await uploadFile(File(image1FromFile));
      await itemDoc
          .update({'image1': image1Url}).then((value) => image1FromFile = '');
    }

    if (image3FromFile.isNotEmpty) {
      image3Url = await uploadFile(File(image3FromFile));
      await itemDoc
          .update({'image3': image3Url}).then((value) => image3FromFile = '');
    }

    await itemDoc.update({
      'title': title,
      'details': details,
      'dayPrice': dayPrice,
      'weekPrice': weekPrice,
      'monthPrice': monthPrice,
      'category': category,
    }).then((value) {
      Get.back();
      return Get.snackbar("Details updated", "",
          backgroundColor: kgreenColor,
          colorText: kwhiteColor,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  @override
  void onClose() {
    firstImage.value = '';
    log(firstImage.value);
    super.onClose();
  }

  // @override
  // void dispose() {
  //   imageFileList.clear();
  //   firstImage = ''.obs;
  //   secondImage = ''.obs;
  //   thirdImage = ''.obs;
  //   super.dispose();
  // }
}
