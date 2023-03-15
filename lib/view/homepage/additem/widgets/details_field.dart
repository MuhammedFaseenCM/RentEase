import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class DetailsFieldWidget extends StatelessWidget {
  const DetailsFieldWidget({super.key});
  static ItemModel itemModel = Get.put(ItemModel());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 160.0,
      decoration: BoxDecoration(
        color: kwhiteColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextFormField(
        controller: itemModel.itemDetailController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: StringConsts.detailsText,
          hintStyle: TextStyle(),
        ),
        maxLines: 5,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter valid details";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
