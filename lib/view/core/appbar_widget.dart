import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rentease/model/homemodel/home_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final int indexValue;
  const AppBarWidget({super.key, required this.title, this.indexValue = 1});
  static final HomeGetx controller = Get.put(HomeGetx());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: kblackColor),
      backgroundColor: kwhiteColor,
      elevation: 0.0,
      flexibleSpace: const AppBarContainer(),
      title: Text(
        title,
        style: const TextStyle(color: kblackColor),
      ),
      // actions: [
      //   // controller.selectedIndex.value == 0
      //   //     ? IconButton(
      //   //         onPressed: () {},
      //   //         icon: const Icon(FontAwesomeIcons.searchengin))
      //   //     : const SizedBox()
      // ],
      centerTitle: true,
    );
  }
}
