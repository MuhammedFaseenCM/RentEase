import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: kbluegreyColor),
                ),
                kwidth10,
                Text(
                  "Muhammed Faseen",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: kblackColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Row(
              children: const [
                Text(
                  "5.6",
                  style: TextStyle(color: kblackColor, fontSize: 15.0),
                ),
                kwidth10,
                Icon(
                  FontAwesomeIcons.solidStar,
                  size: 15.0,
                  color: Colors.orangeAccent,
                )
              ],
            )
          ],
        ),
        kheight20,
        const Text(
          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
          maxLines: 6,
        ),
        kheight20,
      ],
    );
  }
}
