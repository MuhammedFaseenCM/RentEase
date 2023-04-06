import 'package:flutter/material.dart';
import 'package:rentease/view/core/widgets.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(title: const Text('About RentEase'), children: [
      Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'RentEase is a rental app where you can post your rental gadgets for rent and other users can rent them.',
            ),
            kheight10,
            const Text(
              'Version: 1.0.0',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            kheight10,
            Row(
              children: const [
                Text(
                  'Developed by :',
                ),
                kwidth10,
                Text(
                  "Muhammed Faseen C M",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ]))
    ]);
  }
}
