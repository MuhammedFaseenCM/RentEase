import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/model/itemmodel/item_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/additem/widgets/amount_widget.dart';
import 'package:rentease/view/homepage/additem/widgets/details_field.dart';
import 'package:rentease/view/homepage/additem/widgets/dropdownlist_widget.dart';
import 'package:rentease/view/homepage/profile/widget/my_gadgets.dart';

class UpdateGadget extends StatelessWidget {
  final Map<String, dynamic>? itemMap;
  final String? doc;
  const UpdateGadget({super.key, required this.itemMap, required this.doc});
  static final updateGadget = UpdateController();
  static ItemModel itemModel = Get.put(ItemModel());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateGadget.itemTitleController.text = itemMap![titleInMapText];
      updateGadget.itemDetailController.text = itemMap![detailsInMapText] ?? "";
      updateGadget.dayController.text = itemMap![dayPriceInMapText] ?? "";
      updateGadget.weekController.text = itemMap![weekPriceInMapText] ?? "";
      updateGadget.monthController.text = itemMap![monthPriceInMapText] ?? "";
    });

    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: appName),
        ),
        body: CustomContainer(
          child: SingleChildScrollView(
            child: Form(
                key: updateGadget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kheight20,
                    TextFieldWidget(
                      hintText: titleText,
                      controller: updateGadget.itemTitleController,
                      prefixIcon: Icons.add_circle_outline_outlined,
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
                          color: kwhiteColor, fontWeight: FontWeight.w500),
                    ),
                    kheight10,
                    MyDropdownList(),
                    kheight20,
                    DetailsFieldWidget(
                        itemMap: itemMap ?? {},
                        controller: updateGadget.itemDetailController),
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
                          controller: updateGadget.dayController,
                          onChanged: (value) {
                            int day = int.tryParse(value) ?? 0;
                            updateGadget.weekController.text =
                                (day * 7).ceil().toString();
                            updateGadget.monthController.text =
                                (day * 30).ceil().toString();
                          },
                          width: 100.0,
                        ),
                        AmountContainer(
                          hinText: weekText,
                          controller: updateGadget.weekController,
                          width: 100.0,
                        ),
                        AmountContainer(
                          hinText: monthText,
                          controller: updateGadget.monthController,
                          width: 100.0,
                        )
                      ],
                    ),
                    kheight20,
                    const Text(
                      upload3imageText,
                      style: TextStyle(
                          color: kwhiteColor, fontWeight: FontWeight.w500),
                    ),
                    kheight10,
                    UploadImageRow(itemMap: itemMap),
                    Align(
                        alignment: Alignment.center,
                        child: ButtonWidget(
                          width: 150.0,
                          text: saveText,
                          onpressed: (_) {
                            final isValid =
                                updateGadget.formKey.currentState!.validate();

                            if (!isValid) return;

                            updateGadget.updateItem(
                                doc: doc,
                                title: updateGadget.itemTitleController.text,
                                details: updateGadget.itemDetailController.text,
                                dayPrice: updateGadget.dayController.text,
                                weekPrice: updateGadget.weekController.text,
                                monthPrice: updateGadget.monthController.text,
                                category: itemModel.dropdownValue.value);
                          },
                          color: kgreenColor,
                        ))
                  ],
                )),
          ),
        ));
  }
}

class UploadImageRow extends StatelessWidget {
  final Map? itemMap;
  const UploadImageRow({super.key, required this.itemMap});
  static final updateGadget = UpdateController();
  static final updatePutGadget = Get.put(() => UpdateController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kwidth20,
        GetBuilder<UpdateController>(builder: (updateController) {
          return EditImageContainer(
              image: itemMap![firstImageText],
              imageToUpload: updateGadget.firstImage.value);
        }),
        kwidth20,
        EditImageContainer(
            image: itemMap![secondImageText],
            imageToUpload: updateGadget.secondImage),
        kwidth20,
        EditImageContainer(
            image: itemMap![thirdImageText],
            imageToUpload: updateGadget.thirdImage),
      ],
    );
  }
}

class EditImageContainer extends StatelessWidget {
  final String image;
  final String imageToUpload;
  const EditImageContainer(
      {super.key, required this.image, required this.imageToUpload});
  static final updateGadget = UpdateController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageToUpload == ''
            ? MyGadgetImageContainer(image: image)
            : ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.file(
                  File(imageToUpload),
                  fit: BoxFit.cover,
                  height: 100.0,
                  width: 100.0,
                )),
        TextButton.icon(
            onPressed: () {
              updateGadget.updateImage(image: imageToUpload);
            },
            icon: const Icon(
              Icons.edit,
              color: kwhiteColor,
            ),
            label: const Text(
              "Change",
              style: TextStyle(color: kwhiteColor),
            ))
      ],
    );
  }
}
