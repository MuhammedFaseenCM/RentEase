import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class UpdateController extends GetxController {
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
  RxString firstImage = ''.obs;
  String secondImage = '';
  String thirdImage = '';
  Future<void> updateImage({required image}) async {
    final imagePicker = ImagePicker();
    final getImage = await imagePicker.pickImage(source: ImageSource.gallery);
    firstImage.value = getImage!.path;
  }

  Future<void> updateItem(
      {required doc,
      required title,
      required details,
      required dayPrice,
      required weekPrice,
      required monthPrice,
      required category}) async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    ));
    final itemDoc = docRef.doc(doc);
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

  final ImagePicker imagePicker = ImagePicker();
  String image1Url = '';
  String image2Url = '';
  String image3Url = '';

  RxList<XFile> imageFileList = RxList<XFile>();
  Future<void> pickMultipleImage() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
  }
}
