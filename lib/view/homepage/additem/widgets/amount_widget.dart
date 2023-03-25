import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class AmountContainer extends StatelessWidget {
  final String hinText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final double? height;
  final double? width;
  const AmountContainer(
      {super.key,
      required this.hinText,
      required this.controller,
      this.onChanged,
      this.height,
      this.width});
  static ItemModel itemModel = Get.put(ItemModel());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      height: height ?? 60,
      width: width ?? 60,
      decoration: BoxDecoration(
          color: kwhiteColor, borderRadius: BorderRadius.circular(20.0)),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validPriceText;
          }
          final n = int.tryParse(value);
          if (n == null) {
            return validNumberText;
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
