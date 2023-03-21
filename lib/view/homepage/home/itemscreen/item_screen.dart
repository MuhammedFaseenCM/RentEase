import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/home/itemscreen/widget/image_card.dart';

class ItemScreen extends StatelessWidget {
  final Map itemMap;

  const ItemScreen({
    super.key,
    required this.itemMap,
  });

  @override
  Widget build(BuildContext context) {
    String text = itemMap['details'] ?? "Details not available";
    List<String> lines = text.split('\n');
    String bulletText = '';
    for (String line in lines) {
      bulletText += '\u2022 $line\n';
    }
    bool isOwner = false;

    if (itemMap['email'] == FirebaseAuth.instance.currentUser!.email) {
      isOwner = true;
    }
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: StringConsts.appName),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        decoration: boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kheight20,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ImageCard(imageUrl: itemMap['image1']),
                  kwidth10,
                  ImageCard(imageUrl: itemMap['image2']),
                  kwidth10,
                  ImageCard(imageUrl: itemMap['image3'])
                ],
              ),
            ),
            kheight20,
            Text(
              itemMap['title'] ?? "Name not available",
              style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times-New-Roman'),
            ),
            kheight10,
            Text(
              itemMap['dayPrice'] != null
                  ? "Rs.${itemMap['dayPrice']}/day"
                  : "Price not available",
              style: const TextStyle(fontSize: 25.0, fontFamily: 'Roboto'),
            ),
            isOwner
                ? ButtonWidget(
                    text: "Edit your item",
                    onpressed: (p0) {},
                    color: kBlue900,
                  )
                : ButtonWidget(
                    text: "Select a plan",
                    onpressed: (p0) {},
                    color: kgreenColor,
                  ),
            const Text(
              "Details",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            kheight10,
            Text(
              bulletText,
              style: const TextStyle(fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }
}
