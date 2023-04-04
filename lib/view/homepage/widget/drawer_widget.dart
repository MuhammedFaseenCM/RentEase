import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/logout_button.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/widget/listtile_widget.dart';
import 'package:rentease/view/homepage/profile/widget/my_gadgets.dart';

class DrawerWidget extends StatelessWidget {
  final String email;
  const DrawerWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 80.0,
          ),
          const Text(
            signedAsText,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            email,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          kheight10,
          kheight20,
          ListTileWidget(
            title: homeText,
            icon: Icons.home,
            onTap: () {},
          ),
          kheight20,
          ListTileWidget(
            title: addItemText,
            icon: Icons.add,
            onTap: () {},
          ),
          kheight20,
          ListTileWidget(
            title: notifyText,
            icon: Icons.notifications,
            onTap: () {},
          ),
          kheight20,
          ListTileWidget(
            title: myGadgetsText,
            icon: Icons.local_grocery_store_rounded,
            onTap: () {
              Get.to(() => const MyGadgetsScreen());
            },
          ),
          kheight20,
          ListTileWidget(
            title: termsText,
            icon: Icons.assignment,
            onTap: () {
              // Get.to(() => NotifyScreen());
            },
          ),
          kheight20,
          ListTileWidget(
            title: aboutText,
            icon: Icons.info,
            onTap: () {},
          ),
          kheight20,
          const LogoutButton(),
          kheight10
        ],
      ),
    );
  }
}
