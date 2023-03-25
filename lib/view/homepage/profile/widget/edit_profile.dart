import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/fetch_profile_details.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});
  static ProfileControl profile = Get.find<ProfileControl>();
  static ProfileControl profileControl = ProfileControl();
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
            const Text(
              "   Full name*",
              style: TextStyle(color: kwhiteColor),
            ),
            kheight10,
            GetBuilder<ProfileControl>(
                init: ProfileControl(),
                builder: (value) {
                  return TextFieldWidget(
                    hintText: "Full name",
                    controller: value.nameController,
                    validator: (name) {
                      if (name.isEmpty) {
                        return validNameText;
                      }
                    },
                  );
                }),
            kheight20,
            const Text(
              "   Phone number*",
              style: TextStyle(color: kwhiteColor),
            ),
            kheight10,
            GetBuilder<ProfileControl>(
                init: ProfileControl(),
                builder: (value) {
                  return TextFieldWidget(
                    hintText: numberText,
                    controller: value.phoneController,
                    validator: (phone) {
                      if (phone.isEmpty) {
                        return validNumberText;
                      }
                    },
                  );
                }),
            kheight20,
            const Text(
              "   Location*",
              style: TextStyle(color: kwhiteColor),
            ),
            kheight10,
            GetBuilder<ProfileControl>(
                init: ProfileControl(),
                builder: (value) {
                  return TextFieldWidget(
                    hintText: locationText,
                    controller: value.locationController,
                    validator: (location) {
                      if (location.isEmpty) {
                        return validLocationText;
                      }
                    },
                  );
                }),
            kheight20,
            GetBuilder<ProfileControl>(
                init: ProfileControl(),
                builder: (value) {
                  return ButtonWidget(
                    text: saveText,
                    onpressed: (p0) {
                      
                      profileControl.updateDoc(
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
