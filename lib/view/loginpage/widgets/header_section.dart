import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const HeaderSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                    color: kwhiteColor),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                    color: kwhiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}