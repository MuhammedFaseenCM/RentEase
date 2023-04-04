import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/signupmodel/mobx/signup_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/signuppage/widget/image_widget.dart';

class SignUpSecondScreen extends StatelessWidget {
  final String email;
  final String password;
  const SignUpSecondScreen(
      {super.key, required this.email, required this.password});
  static final SignUpModel signupmodel = SignUpModel();
  static final signupformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: signupText)),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: boxDecoration,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: signupformKey,
              child: Column(
                children: [
                  kheight20,
                  TextFieldWidget(
                    hintText: locationText,
                    controller: signupmodel.locationController,
                    prefixIcon: const Icon(Icons.location_on),
                    validator: (value) {
                      if (value.isEmpty) {
                        return validLocationText;
                      }
                    },
                  ),
                  kheight20,
                  Obx(
                    () => InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) =>
                                BottomSheetWidget(imageFunction: signupmodel)),
                          );
                        },
                        child: signupmodel.picture == ''
                            ? const ImageWidget(
                                image: "",
                                imageText: idImageText,
                              )
                            : ImageWidget(
                                image: signupmodel.picture,
                                imageText: "",
                              )),
                  ),
                  kheight20,
                  ButtonWidget(
                    text: signupText,
                    onpressed: (context) async {
                      final isValid = signupformKey.currentState!.validate();
                      if (!isValid) return;
                      if (signupmodel.picture.isEmpty) {
                        Get.snackbar(addIDText, "",
                            backgroundColor: kredColor, colorText: kwhiteColor);
                        return;
                      }
                      signupmodel.sendSMS(context: context);

                      // await signUp(
                      //     context: context, email: email, password: password);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
