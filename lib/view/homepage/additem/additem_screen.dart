import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/additem/add_item_fun.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/address_sheet.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/additem/widgets/amount_widget.dart';
import 'package:rentease/view/homepage/additem/widgets/details_field.dart';
import 'package:rentease/view/homepage/additem/widgets/dropdownlist_widget.dart';
import 'package:rentease/view/homepage/additem/widgets/image_select_widget.dart';

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
          decoration: boxDecoration,
          child: Form(
            key: itemModel.itemformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight20,
                TextFormField(
                  controller: itemModel.itemTitleController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.add_circle_outline_outlined),
                      labelText: titleText,
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return validTitleText;
                    } else {
                      return null;
                    }
                  },
                ),
                kheight20,
                const Text(
                  categoryText,
                  style: TextStyle(
                      color: kblackColor, fontWeight: FontWeight.w500),
                ),
                kheight10,
                MyDropdownList(),
                kheight20,
                DetailsFieldWidget(controller: itemModel.itemDetailController),
                kheight20,
                const Text(
                  priceText,
                  style: TextStyle(
                      color: kwhiteColor, fontWeight: FontWeight.w500),
                ),
                kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AmountContainer(
                      hinText: dayText,
                      controller: itemModel.dayController,
                      onChanged: (value) {
                        int day = int.tryParse(value) ?? 0;
                        itemModel.weekController.text =
                            (day * 7).ceil().toString();
                        itemModel.monthController.text =
                            (day * 30).ceil().toString();
                      },
                      width: 100.0,
                    ),
                    AmountContainer(
                      hinText: weekText,
                      controller: itemModel.weekController,
                      width: 100.0,
                    ),
                    AmountContainer(
                      hinText: monthText,
                      controller: itemModel.monthController,
                      width: 100.0,
                    )
                  ],
                ),
                kheight10,
                const Text(
                  upload3imageText,
                  style: TextStyle(
                      color: kwhiteColor, fontWeight: FontWeight.w500),
                ),
                ButtonWidget(
                  text: imagesText,
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
                    text: saveText,
                    onpressed: (p0) {
                      final isValid =
                          itemModel.itemformKey.currentState!.validate();
                      if (!isValid) return;
                      if (itemModel.imageFileList.length != 3) {
                        Get.snackbar(upload3imageText, "",
                            backgroundColor: kredColor,
                            colorText: kwhiteColor,
                            snackPosition: SnackPosition.BOTTOM);
                        return;
                      }

                      showAddressSheet(context: context, isAddItem: true);
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
