import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/widget/image_widget.dart';

class UserRequestDetails extends StatelessWidget {
  final Map reqMap;
  final String docId;
  const UserRequestDetails(
      {super.key, required this.reqMap, required this.docId});

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
                    content: reqMap['userEmail'], icon: Icons.mail),
                kheight20,
                const TitleWidget(title: "User number"),
                kheight10,
                CustomDetailContainer(
                    content: reqMap['phoneNumber'], icon: Icons.call),
                // kheight20,
                // const TitleWidget(title: "User ID"),
                // kheight20,
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10.0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: 180.0,
                //     color: kwhiteColor,
                //     child: Image.network(reqMap['idImage'], fit: BoxFit.cover,
                //         loadingBuilder: (context, child, loadingProgress) {
                //       if (loadingProgress == null) {
                //         return child;
                //       } else {
                //         return Container(
                //             decoration: BoxDecoration(
                //               color: kgrey,
                //               borderRadius: BorderRadius.circular(20.0),
                //             ),
                //             width: MediaQuery.of(context).size.width,
                //             height: 180.0,
                //             child: Center(
                //               child: BlurHash(
                //                 imageFit: BoxFit.cover,
                //                 duration: const Duration(seconds: 4),
                //                 curve: Curves.bounceInOut,
                //                 hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                //                 image: reqMap['idImage'],
                //               ),
                //             ));
                //       }
                //     }, errorBuilder: (context, error, stackTrace) {
                //       return Container(
                //         decoration: BoxDecoration(
                //           color: kgrey,
                //           borderRadius: BorderRadius.circular(20.0),
                //         ),
                //         width: MediaQuery.of(context).size.width,
                //         height: 180.0,
                //         child: const Center(
                //           child: Icon(
                //             Icons.error,
                //             color: kwhiteColor,
                //             size: 30.0,
                //           ),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
                kheight20,
                const TitleWidget(title: "User address"),
                kheight10,
                CustomDetailContainer(
                    height: 120.0,
                    content:
                        "${reqMap['address']['houseNo']}\n${reqMap['address']['area']}\n${reqMap['address']['city']}\n${reqMap['address']['pincode']}\n${reqMap['address']['state']}",
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
                        ReqImageWidget(imageUrl: reqMap['image1']),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWidget(title: "Product name"),
                        kheight10,
                        CustomDetailContainer(
                            width: 200.0,
                            content: reqMap['title'],
                            icon: Icons.add_circle_outline_outlined),
                        kheight20,
                        const TitleWidget(title: "Plan"),
                        kheight10,
                        CustomDetailContainer(
                            width: 200.0,
                            content: reqMap['plan'],
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
          // Positioned(
          //   bottom: 0.0,
          //   //  left: MediaQuery.of(context).size.width / 5,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 60.0,
          //     color: kwhiteColor,
          //     child: GetBuilder(
          //         init: NotifyController(),
          //         builder: (context) {
          //           return ReqButtonsWidget(map: reqMap, docId: docId);
          //         }),
          //   ),
          // ),
        ],
      ),
    );
  }
}

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
