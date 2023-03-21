import 'package:flutter/material.dart';
import 'package:rentease/view/core/logout_button.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/widget/listtile_widget.dart';

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
            "Signed In as",
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
          ListTileWidget(
            title: "My Gadgets",
            icon: Icons.local_grocery_store_rounded,
            onTap: () {},
          ),
          kheight20,
          ListTileWidget(
            title: "Terms and Policies",
            icon: Icons.assignment,
            onTap: () {},
          ),
          kheight20,
          ListTileWidget(
            title: "About",
            icon: Icons.info,
            onTap: () {},
          ),
          kheight20,
          ListTileWidget(
            title: "Terms and Policies",
            icon: Icons.assignment,
            onTap: () {},
          ),
          kheight20,
          ListTileWidget(
            title: "About",
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
