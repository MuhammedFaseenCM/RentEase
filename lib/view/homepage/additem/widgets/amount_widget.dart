import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/const_colors.dart';

class AmountContainer extends StatelessWidget {
  final String hinText;
  final TextEditingController controller;
  const AmountContainer(
      {super.key, required this.hinText, required this.controller});
  static ItemModel itemModel = Get.put(ItemModel());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: kwhiteColor, borderRadius: BorderRadius.circular(20.0)),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (itemModel.dayController.text.isEmpty) {
            itemModel.monthController.clear();
            itemModel.weekController.clear();
          }
          itemModel.onPriceChange();
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter a valid amount";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinText,
            hintStyle: const TextStyle()),
      ),
    );
  }
}
