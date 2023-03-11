import 'package:flutter/material.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/homepage/home/widget/item_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: boxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ItemContainer();
          },
        ),
      ),
    );
  }
}
