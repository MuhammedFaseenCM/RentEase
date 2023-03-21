import 'package:flutter/material.dart';

import 'package:rentease/view/core/const_colors.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ListTileWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 80.0,
      decoration: const BoxDecoration(color: kwhiteColor, boxShadow: [
        BoxShadow(color: kblackColor, blurRadius: 5.0),
      ]),
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        leading: Icon(icon),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
