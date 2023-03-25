import 'package:flutter/material.dart';
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
          selectedItemColor: kblackColor,
          iconSize: 30.0,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTabIndex,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: kblackColor,
                ),
                label: homeText),
            const BottomNavigationBarItem(
                icon: IconButtonWidget(icon: Icons.add), label: addItemText),
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: kblackColor,
                    ),
                    GetBuilder(
                        init: NotifyController(),
                        builder: (value) {
                          return Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: value.notfyIconController
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: kredColor,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      height: 15.0,
                                      width: 15.0,
                                      // child: Center(
                                      //   child: Text(
                                      //     value.itemsLength.toString(),
                                      //     style: const TextStyle(
                                      //         fontSize: 10.0,
                                      //         color: kwhiteColor),
                                      //   ),
                                      // ),
                                    )
                                  : const SizedBox());
                        })
                  ],
                ),
                label: notifyText),
            const BottomNavigationBarItem(
                icon: IconButtonWidget(icon: Icons.drive_folder_upload_sharp),
                label: ordersText),
            const BottomNavigationBarItem(
                icon: IconButtonWidget(icon: Icons.person), label: accText),
          ]),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  const IconButtonWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: kblackColor,
    );
  }
}
