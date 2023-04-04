import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/notification/notify_control.dart';
import 'package:rentease/model/homemodel/home_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

var selectedPage = 0;

class BottomNavigationBarWidget extends GetView<HomeGetx> {
  const BottomNavigationBarWidget({super.key});
  static final notifycontrol = NotifyController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
          backgroundColor: Colors.orange[900],
          selectedItemColor: kblackColor,
          iconSize: 30.0,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTabIndex,
          items: [
            BottomNavigationBarItem(
                //  backgroundColor: Colors.orange[900],
                icon: Icon(
                  FontAwesomeIcons.house,
                  size: 20.0,
                  color: kblackColor,
                ),
                label: homeText),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.plus,
                  color: kblackColor,
                  size: 20.0,
                ),
                label: addItemText),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.bell,
                  color: kblackColor,
                  size: 20.0,
                ),
                label: notifyText),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.upload,
                  color: kblackColor,
                  size: 20.0,
                ),
                label: ordersText),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.person,
                  color: kblackColor,
                  size: 20.0,
                ),
                label: accText),
          ]),
    );
  }
}
