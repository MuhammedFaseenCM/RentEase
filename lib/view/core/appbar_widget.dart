import 'package:flutter/material.dart';
import 'package:rentease/view/core/widgets.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme:const IconThemeData(color: Colors.black),
      backgroundColor: Colors.orange[900],
      elevation: 0.0,
      flexibleSpace: const AppBarContainer(),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
