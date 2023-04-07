import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';

class CustomDetailContainer extends StatelessWidget {
  final String content;
  final IconData icon;
  final double? width;
  final double? height;
  const CustomDetailContainer(
      {super.key,
      required this.content,
      required this.icon,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 40.0,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.grey, blurRadius: 1.0, spreadRadius: 1.0)
      ], color: kwhiteColor, borderRadius: BorderRadius.circular(20.0)),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Icon(icon),
          kwidth10,
          Flexible(
            child: Text(content,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: kblackColor)),
          ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: kblackColor));
  }
}
