import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/const_colors.dart';

class ImageSelectWidget extends StatelessWidget {
  const ImageSelectWidget({super.key});
  static ItemModel itemModel = Get.put(ItemModel());
  @override
  Widget build(BuildContext context) {
    return GetX<ItemModel>(builder: (_) {
      if (itemModel.imageFileList.isEmpty) {
        return const SizedBox();
      }
      return Container(
        padding: const EdgeInsets.all(5.0),
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: kblackColor),
            color: kwhiteColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Image.file(
                File(itemModel.imageFileList[index].path),
                fit: BoxFit.cover,
              );
            },
            itemCount: itemModel.imageFileList.length),
      );
    });
  }
}
