import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class DetailsFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  const DetailsFieldWidget({
    super.key,
    required this.controller,
  });
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
          border: OutlineInputBorder(),
          labelText: detailsText,
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
