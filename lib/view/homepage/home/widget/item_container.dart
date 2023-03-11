import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 180,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes the position of the shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}
