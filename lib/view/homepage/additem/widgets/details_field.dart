import 'package:flutter/material.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class DetailsFieldWidget extends StatelessWidget {
  final Map<String, dynamic>? itemMap;
  final TextEditingController controller;
  const DetailsFieldWidget({super.key, this.itemMap, required this.controller});
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
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: detailsText,
          hintStyle: TextStyle(),
        ),
        maxLines: 5,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validDetailsText;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
