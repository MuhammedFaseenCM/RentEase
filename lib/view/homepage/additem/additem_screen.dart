import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/additem/widgets/amount_widget.dart';
import 'package:rentease/view/homepage/additem/widgets/details_field.dart';
import 'package:rentease/view/homepage/additem/widgets/dropdownlist_widget.dart';
import 'package:rentease/view/homepage/additem/widgets/image_select_widget.dart';

class AddItemScreen extends StatelessWidget {
  final String? email;
  const AddItemScreen({super.key, required this.email});
  static ItemModel itemModel = Get.put(ItemModel());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: boxDecoration,
          child: Form(
            key: itemModel.itemformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight20,
                TextFieldWidget(
                  hintText: StringConsts.titleText,
                  controller: itemModel.itemTitleController,
                  prefixIcon: Icons.add_circle_outline_outlined,
                  validator: (value) {
                    if (value == null ||  value.isEmpty) {
                      return "\tEnter a valid title\n";
                    } else {
                      return null;
                    }
                  },
                ),
                kheight20,
                const Text(
                  StringConsts.categoryText,
                  style: TextStyle(
                      color: kwhiteColor, fontWeight: FontWeight.w500),
                ),
                kheight10,
                MyDropdownList(),
                kheight20,
                const DetailsFieldWidget(),
                kheight20,
                const Text(
                  StringConsts.priceText,
                  style: TextStyle(
                      color: kwhiteColor, fontWeight: FontWeight.w500),
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
                Align(
                  alignment: Alignment.center,
                  child: ButtonWidget(
                    width: 150.0,
                    text: "Submit",
                    onpressed: (p0) {
                      final isValid =
                          itemModel.itemformKey.currentState!.validate();
                      if (!isValid) return;
                      itemModel.storeToFirestore(
                          categoryValue: itemModel.dropdownValue.value,
                          email: email);
                    },
                    color: kgreenColor,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
