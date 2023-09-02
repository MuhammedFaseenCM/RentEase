import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/profile_controller.dart';

class EditProfile extends GetView<ProfileController> {
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: appName),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        decoration: boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kheight20,
            kheight20,
            GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (value) {
                  return TextFormField(
                    controller: value.nameController,
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return validNameText;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: fullnameText,
                      border: OutlineInputBorder(),
                    ),
                  );
                }),
            kheight20,
            const Text(
              "   Phone number*",
              style: TextStyle(color: kwhiteColor),
            ),
            kheight10,
            GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (value) {
                  return TextFormField(
                    controller: value.phoneController,
                    validator: (number) {
                      if (number == null || number.isEmpty) {
                        return validNumberText;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: numberText,
                      border: OutlineInputBorder(),
                    ),
                  );
                }),
            kheight20,
            const Text(
              "   Location*",
              style: TextStyle(color: kwhiteColor),
            ),
            kheight20,
            GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (value) {
                  return ButtonWidget(
                    text: saveText,
                    onpressed: (p0) {
                      controller.updateDoc(
                          name: value.nameController.text,
                          phone: value.phoneController.text,
                          location: value.locationController.text);
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
