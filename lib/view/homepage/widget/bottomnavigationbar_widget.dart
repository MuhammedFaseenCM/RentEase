import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/homemodel/home_model.dart';

var selectedPage = 0;

class BottomNavigationBarWidget extends GetView<HomeGetx> {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
          selectedItemColor: Colors.black,
          iconSize: 30.0,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTabIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: IconButtonWidget(icon: Icons.add), label: "Add item"),
            BottomNavigationBarItem(
                icon: IconButtonWidget(icon: Icons.notifications),
                label: "Notifications"),
            BottomNavigationBarItem(
                icon: IconButtonWidget(icon: Icons.drive_folder_upload_sharp),
                label: "Orders"),
            BottomNavigationBarItem(
                icon: IconButtonWidget(icon: Icons.person), label: "Account"),
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
      color: Colors.black,
    );
  }
}
