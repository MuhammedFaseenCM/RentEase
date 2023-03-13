import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ItemModel extends GetxController {
  TextEditingController iteTitleController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController weekController = TextEditingController();
  TextEditingController monthController = TextEditingController();

  var dropdownValue = 'Electronics'.obs;

  final ImagePicker imagePicker = ImagePicker();

  void onDropdownChanged(String value) {
    dropdownValue.value = value;
  }

  void onPriceChange() {
    int day = int.parse(dayController.text);
    weekController.text = (day * 7).toString();
    monthController.text = (day * 30).toString();
  }

  RxList<XFile> imageFileList = RxList<XFile>();
  Future<void> pickMultipleImage() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();

      Reference referenceDirImages = referenceRoot.child('images');

      for (var i = 0; i < selectedImages.length; i++) {
        Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);
        await referenceImageToUpload.putFile(File(selectedImages[i]!.path));

        await referenceImageToUpload.getDownloadURL();
      }
    }
  }
}
