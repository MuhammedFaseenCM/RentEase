import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rentease/main.dart';
import 'package:rentease/model/signupmodel/signup_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/textformfield.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/controller/signup/signup_function.dart';
import 'package:rentease/view/signuppage/widget/image_widget.dart';

TextEditingController locationController = TextEditingController();

class SignUpSecondScreen extends StatelessWidget {
  final String email;
  final String password;
  const SignUpSecondScreen(
      {super.key, required this.email, required this.password});
  static final SignUpModel signupmodel = Get.put(SignUpModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: "Signup")),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: boxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                kheight20,
                TextFieldWidget(
                    hintText: "Location", controller: locationController),
                kheight20,
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) =>
                            BottomSheetWidget(imageFunction: signupmodel)),
                      );
                    },
                    child: signupmodel.picture == ''
                        ? const ImageWidget(image: "",imageText: StringConsts.idImageText,)
                        : ImageWidget(image: signupmodel.picture,imageText: "",)),
                kheight20,
                ButtonWidget(
                  text: "Signup",
                  onpressed: (context) {
                    signUp(context: context, email: email, password: password);
                    signupmodel.picture = '';
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
