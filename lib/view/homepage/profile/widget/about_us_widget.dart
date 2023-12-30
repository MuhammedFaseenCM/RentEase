import 'package:flutter/material.dart';
import 'package:rentease/view/core/widgets.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Row(
          children: [
            const Text('About '),
            SizedBox(
              height: 30.0,
              width: 30.0,
              child: Image.asset("asset/images/launcher.png"),
            ),
            const Text('entEase'),
          ],
        ),
        children: const [
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RentEase is a rental app where you can post your rental gadgets for rent and other users can rent them.',
                    ),
                    kheight10,
                    Text(
                      'Version: 1.0.0',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    kheight10,
                    Row(
                      children: [
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
