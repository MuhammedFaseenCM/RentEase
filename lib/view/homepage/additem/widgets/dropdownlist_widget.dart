import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class MyDropdownList extends StatelessWidget {
  final ItemModel itemModel = Get.put(ItemModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: kblackColor,
              ),
              color: kwhiteColor,
              borderRadius: BorderRadius.circular(20.0)),
          width: MediaQuery.of(context).size.width / 2,
          child: DropdownButton<String>(
            
            alignment: AlignmentDirectional.center,
            value: itemModel.dropdownValue.value,
            onChanged: (value) {
              itemModel.onDropdownChanged(value!);
            },
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
          ),
        ));
  }
}
