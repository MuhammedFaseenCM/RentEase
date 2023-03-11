import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/additem/additem_screen2.dart';
import 'package:rentease/view/homepage/additem/widgets/amount_widget.dart';
import 'package:rentease/view/signuppage/widget/image_widget.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});
  static ItemModel itemModel = Get.put(ItemModel());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: boxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kheight20,
              TextFieldWidget(
                hintText: StringConsts.titleText,
                controller: itemModel.iteTitleController,
                prefixIcon: Icons.add_circle_outline_outlined,
              ),
              kheight20,
              const Text(
                StringConsts.categoryText,
                style:
                    TextStyle(color: kwhiteColor, fontWeight: FontWeight.w500),
              ),
              kheight10,
              MyDropdownList(),
              kheight20,
              Container(
                height: 160.0,
                decoration: BoxDecoration(
                  color: kwhiteColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: StringConsts.detailsText,
                      hintStyle: TextStyle()),
                  maxLines: 5,
                ),
              ),
              kheight20,
              const Text(
                StringConsts.priceText,
                style:
                    TextStyle(color: kwhiteColor, fontWeight: FontWeight.w500),
              ),
              kheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AmountContainer(
                      hinText: StringConsts.dayText,
                      controller: itemModel.dayController),
                  AmountContainer(
                      hinText: StringConsts.weekText,
                      controller: itemModel.weekController),
                  AmountContainer(
                    hinText: StringConsts.monthText,
                    controller: itemModel.monthController,
                  )
                ],
              ),
              kheight10,
              ButtonWidget(
                text: StringConsts.imagesText,
                onpressed: (context) {
                  itemModel.imageFileList.clear();
                  itemModel.pickMultipleImage();
                },
                width: 160.0,
                height: 35.0,
                color: kgrey,
              ),
              const ImageSelectWidget(),
            ],
          )),
    );
  }
}

class MyDropdownList extends StatelessWidget {
  final ItemModel itemModel = Get.put(ItemModel());

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class ImageSelectWidget extends StatelessWidget {
  const ImageSelectWidget({super.key});
  static ItemModel itemModel = Get.put(ItemModel());
  @override
  Widget build(BuildContext context) {
    return GetX<ItemModel>(
        builder: (_) => Container(
              padding: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: kwhiteColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Image.file(
                      File(itemModel.imageFileList[index].path),
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: itemModel.imageFileList.length),
            ));
  }
}
