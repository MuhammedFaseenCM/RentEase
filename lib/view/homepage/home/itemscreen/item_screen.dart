import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/model/homemodel/gadgets.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/home/itemscreen/widget/image_card.dart';
import 'package:rentease/view/homepage/home/itemscreen/widget/review_widget.dart';
import 'package:rentease/view/homepage/home/itemscreen/widget/selectplan_screen.dart';
import 'package:rentease/view/homepage/home/widget/rating_widget.dart';
import 'package:rentease/view/homepage/profile/widget/update_gadgets.dart';

class ItemScreen extends StatelessWidget {
  final String doc;
  final Gadgets gadget;
  const ItemScreen({
    super.key,
    required this.doc,
    required this.gadget,
  });
  static final updateGadget = UpdateController();

  @override
  Widget build(BuildContext context) {
    String text = gadget.details;
    List<String> lines = text.split('\n');
    String bulletText = '';
    for (String line in lines) {
      bulletText += '\u2022 $line\n';
    }
    bool isOwner = false;

    if (gadget.email == FirebaseAuth.instance.currentUser!.email) {
      isOwner = true;
    }
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: appName),
      ),
      body: CustomContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kheight20,
              Text(gadget.title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: kblackColor, fontWeight: FontWeight.bold)),
              kheight20,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Hero(
                        tag: gadget.image1,
                        child: ImageCard(imageUrl: gadget.image1)),
                    kwidth10,
                    ImageCard(imageUrl: gadget.image2),
                    kwidth10,
                    ImageCard(imageUrl: gadget.image3)
                  ],
                ),
              ),
              kheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Price\n",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: kblackColor,
                                    fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "₹${gadget.dayPrice}/day",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: kblackColor,
                                    fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  RatingWidget(ownerEmail: gadget.email, title: gadget.title)
                ],
              ),
              kheight10,
              kDivider(context),
              kheight10,
              Text(
                detailsText,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: kblackColor, fontWeight: FontWeight.bold),
              ),
              kheight10,
              Text(
                bulletText,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: kblackColor,
                    ),
              ),
              kheight10,
              kDivider(context),
              kheight10,
              isOwner
                  ? BookingButton(
                      onpressed: () {
                        Get.to(() => UpdateGadget(
                              gadget: gadget,
                              doc: doc,
                            ));
                      },
                      color: kBlue900,
                      text: editItemText)
                  : BookingButton(
                      onpressed: () {
                        gadget.available == 'true'
                            ? Get.to(() =>
                                SelectPlanScreen(gadget: gadget, doc: doc))
                            : null;
                      },
                      color: gadget.available == 'true' ? kgreenColor : kgrey,
                      text: gadget.available == 'true'
                          ? selectPlanText
                          : 'Unavailable'),
              kheight20,
              Text(
                "Reviews",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: kblackColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              kheight10,
              ReviewWidget(
                ownerEmail: gadget.email,
                title: gadget.title,
              ),
            ],
          ),
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
