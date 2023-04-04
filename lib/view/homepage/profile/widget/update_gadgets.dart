import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/model/homemodel/gadgets.dart';
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
  // final Map<String, dynamic> itemMap;
  final String? doc;
  final Gadgets gadget;
  const UpdateGadget({super.key, required this.doc, required this.gadget});
  static final updateGadget = UpdateController();
  static ItemModel itemModel = Get.put(ItemModel());
  static UpdateController updatePutGadget = Get.put(UpdateController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateGadget.itemTitleController.text = gadget.title;
      updateGadget.itemDetailController.text = gadget.details;
      updateGadget.dayController.text = gadget.dayPrice;
      updateGadget.weekController.text = gadget.weekPrice;
      updateGadget.monthController.text = gadget.monthPrice;
    });
    updateGadget.firstImage.value = '';
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
                    TextFormField(
                      controller: updateGadget.itemTitleController,
                      decoration: const InputDecoration(
                          labelText: titleText,
                          prefixIcon: Icon(Icons.add_circle_outline_outlined),
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
                    DetailsFieldWidget(
                        controller: updateGadget.itemDetailController),
                    kheight20,
                    const Text(
                      priceText,
                      style: TextStyle(
                          color: kblackColor, fontWeight: FontWeight.w500),
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
                          color: kblackColor, fontWeight: FontWeight.w500),
                    ),
                    kheight10,
                    UploadImageRow(
                      gadget: gadget,
                    ),
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
                                category: itemModel.dropdownValue.value,
                                selectedfirstImage: updateGadget.firstImage,
                                selectedsecondImage: updateGadget.secondImage,
                                selectedthirdImage: updateGadget.thirdImage);
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
  final Gadgets gadget;
  const UploadImageRow({super.key, required this.gadget});
  static UpdateController updateGadget = UpdateController();
  // static final updatePutGadget = Get.put(() => UpdateController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kwidth20,
        EditImageContainer(
          image: gadget.image1,
          imageToUpload: updateGadget.firstImage,
          index: 1,
        ),
        kwidth20,
        EditImageContainer(
          image: gadget.image2,
          imageToUpload: updateGadget.secondImage,
          index: 2,
        ),
        kwidth20,
        EditImageContainer(
          image: gadget.image3,
          imageToUpload: updateGadget.thirdImage,
          index: 3,
        ),
      ],
    );
  }
}

class EditImageContainer extends StatelessWidget {
  final String image;
  final RxString imageToUpload;
  final int index;
  EditImageContainer(
      {super.key,
      required this.image,
      required this.imageToUpload,
      required this.index});
  final UpdateController updateGadget = Get.put(UpdateController());
  @override
  Widget build(BuildContext context) {
    imageToUpload.value = '';
    return Obx(() {
      if (imageToUpload.value.isEmpty) {
        return Column(
          children: [
            MyGadgetImageContainer(image: image),
            TextButton.icon(
                onPressed: () async {
                  if (index == 1) {
                    await updateGadget.updateImage(image: imageToUpload);
                    image1FromFile = imageToUpload.value;
                  } else if (index == 2) {
                    await updateGadget.updateImage(image: imageToUpload);
                    image2FromFile = imageToUpload.value;
                  } else if (index == 3) {
                    await updateGadget.updateImage(image: imageToUpload);
                    image3FromFile = imageToUpload.value;
                  } else {
                    log("error");
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  color: kblackColor,
                ),
                label: const Text(
                  "Change",
                  style: TextStyle(color: kblackColor),
                ))
          ],
        );
      }

      return Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.file(
                File(imageToUpload.value),
                fit: BoxFit.cover,
                height: 100.0,
                width: 100.0,
              )),
          TextButton.icon(
              onPressed: () async {
                if (index == 1) {
                  await updateGadget.updateImage(image: imageToUpload);
                  image1FromFile = imageToUpload.value;
                } else if (index == 2) {
                  await updateGadget.updateImage(image: imageToUpload);
                  image2FromFile = imageToUpload.value;
                } else if (index == 3) {
                  await updateGadget.updateImage(image: imageToUpload);
                  image3FromFile = imageToUpload.value;
                } else {
                  log("error");
                }
              },
              icon: const Icon(
                Icons.edit,
                color: kblackColor,
              ),
              label: const Text(
                "Change",
                style: TextStyle(color: kblackColor),
              ))
        ],
      );
    });
  }
}
