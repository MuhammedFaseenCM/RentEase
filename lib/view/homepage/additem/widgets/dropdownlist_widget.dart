import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/const_colors.dart';

class MyDropdownList extends StatelessWidget {
  final ItemModel itemModel = Get.put(ItemModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
              color: kwhiteColor, borderRadius: BorderRadius.circular(20.0)),
          width: MediaQuery.of(context).size.width,
          child: DropdownButton<String>(
            alignment: AlignmentDirectional.center,
            value: itemModel.dropdownValue.value,
            onChanged: (value) {
              itemModel.onDropdownChanged(value!);
            },
            items: <String>[
              'Electronics',
              'Bikes & Bicycles',
              'Travel gadgets',
              'Others'
            ].map<DropdownMenuItem<String>>((String value) {
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
