import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/string_consts.dart';

Future<void> addAddressForItemFunction({required address}) async {
  ItemModel itemModel = Get.put(ItemModel());
  Get.dialog(AlertDialog(
    title: const Text(warningText),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(cancelText)),
      TextButton(
          onPressed: () async {
            Get.back();
            await itemModel.storeToFirestore(
                categoryValue: itemModel.dropdownValue.value,
                email: FirebaseAuth.instance.currentUser!.email.toString(),
                address: address);
            await Future.delayed(const Duration(seconds: 1));
            Get.back();
            Get.back();
          },
          child: const Text(confirmText)),
    ],
  ));
}
