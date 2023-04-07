import 'package:flutter/material.dart';
import 'package:rentease/model/addressmodel/address_model.dart';
import 'package:rentease/model/requestmodel/sendreqmodel.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/widget/image_widget.dart';
import 'package:rentease/view/homepage/notification/widget/user_details_container.dart';

class UserRequestDetailsScreen extends StatelessWidget {
  
  final String docId;
  final AddressModel address;
  final SendRequestModel sendReq;

  const UserRequestDetailsScreen(
      {super.key,
      required this.docId,
      required this.address,
      required this.sendReq});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: appName),
      ),
      body: Stack(
        children: [
          CustomContainer(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight20,
                Center(
                    child: Text("User details",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: kblackColor,
                                fontWeight: FontWeight.bold))),
                kheight10,
                const TitleWidget(title: "User email"),
                kheight10,
                CustomDetailContainer(
                    content: sendReq.userEmail, icon: Icons.mail),
                kheight20,
                const TitleWidget(title: "User number"),
                kheight10,
                CustomDetailContainer(
                    content: sendReq.phoneNumber, icon: Icons.call),
                kheight20,
                const TitleWidget(title: "User address"),
                kheight10,
                CustomDetailContainer(
                    height: 120.0,
                    content:
                        "${address.houseNo}\n${address.area}\n${address.city}\n${address.pinCode}\n${address.state}",
                    icon: Icons.house),
                kheight20,
                Center(
                    child: Text("Product details",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: kblackColor,
                                fontWeight: FontWeight.bold))),
                kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const TitleWidget(title: "Product image"),
                        kheight10,
                        ReqImageWidget(imageUrl: sendReq.image1),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWidget(title: "Product name"),
                        kheight10,
                        CustomDetailContainer(
                            width: 200.0,
                            content: sendReq.title,
                            icon: Icons.add_circle_outline_outlined),
                        kheight20,
                        const TitleWidget(title: "Plan"),
                        kheight10,
                        CustomDetailContainer(
                            width: 200.0,
                            content: sendReq.plan,
                            icon: Icons.calendar_today),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80.0,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
