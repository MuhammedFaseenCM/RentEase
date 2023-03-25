import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/home/itemscreen/widget/image_card.dart';
import 'package:rentease/view/homepage/home/itemscreen/widget/selectplan_screen.dart';
import 'package:rentease/view/homepage/profile/widget/update_gadgets.dart';

class ItemScreen extends StatelessWidget {
  final Map<String, dynamic> itemMap;
  final String doc;
  const ItemScreen({
    super.key,
    required this.itemMap,
    required this.doc,
  });
  static final updateGadget = UpdateController();

  @override
  Widget build(BuildContext context) {
    String text = itemMap[detailsInMapText] ?? detailNullText;
    List<String> lines = text.split('\n');
    String bulletText = '';
    for (String line in lines) {
      bulletText += '\u2022 $line\n';
    }
    bool isOwner = false;

    if (itemMap[emailInMapText] == FirebaseAuth.instance.currentUser!.email) {
      isOwner = true;
    }
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: appName),
      ),
      body: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kheight20,
            Text(itemMap[titleInMapText] ?? titleNullText,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: kwhiteColor, fontWeight: FontWeight.bold)),
            kheight20,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Hero(
                      tag: itemMap[firstImageText],
                      child: ImageCard(imageUrl: itemMap[firstImageText])),
                  kwidth10,
                  ImageCard(imageUrl: itemMap[secondImageText]),
                  kwidth10,
                  ImageCard(imageUrl: itemMap[thirdImageText])
                ],
              ),
            ),
            kheight10,
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: "Price\n"),
                  TextSpan(
                      text: "\$${itemMap['dayPrice']}/day",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: kwhiteColor, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            kheight20,
            Text(
              detailsText,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: kwhiteColor, fontWeight: FontWeight.bold),
            ),
            kheight10,
            Text(
              bulletText,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: kwhiteColor, fontWeight: FontWeight.bold),
            ),
            isOwner
                ? BookingButton(
                    onpressed: () {
                      Get.to(() => UpdateGadget(
                            itemMap: itemMap,
                            doc: doc,
                          ));
                    },
                    color: kBlue900,
                    text: editItemText)
                : BookingButton(
                    onpressed: () {
                      Get.to(() => SelectPlanScreen(
                            itemMap: itemMap,
                          ));
                    },
                    color: kgreenColor,
                    text: selectPlanText)
          ],
        ),
      ),
    );
  }
}

class BookingButton extends StatelessWidget {
  final VoidCallback onpressed;
  final Color? color;
  final String text;
  const BookingButton(
      {super.key,
      required this.onpressed,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50.0,
        width: 230.0,
        child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              side: BorderSide.none,
              shape: const StadiumBorder()),
          child: Text(
            text.toUpperCase(),
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: kwhiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
