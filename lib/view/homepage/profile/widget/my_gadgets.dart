import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/mygadgets/mygadgets_control.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/home/itemscreen/item_screen.dart';
import 'package:rentease/view/homepage/profile/widget/update_gadgets.dart';

class MyGadgetsScreen extends StatelessWidget {
  const MyGadgetsScreen({super.key});
  static final myGadget = MyGadgetsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: myGadgetsText),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: boxDecoration,
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: myGadget.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot? querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
                  List<Map<String, dynamic>> items = documents
                      .map((e) => e.data() as Map<String, dynamic>)
                      .where((map) =>
                          map[emailInMapText] ==
                          FirebaseAuth.instance.currentUser!.email.toString())
                      .toList();
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> thisItem = items[index];
                      if (items.isEmpty) {
                        return const Center(
                          child: Text(
                            noGadgetsText,
                            style: TextStyle(
                                color: kwhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                        );
                      }

                      return InkWell(
                        onTap: () => Get.to(() => ItemScreen(
                              itemMap: thisItem,
                              doc: documents[index].id,
                            )),
                        child: GadgetContainer(
                            thisItem: thisItem,
                            documents: documents,
                            index: index),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      wrongText,
                      style: TextStyle(
                          color: kwhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
  }
}

class GadgetContainer extends StatelessWidget {
  final Map thisItem;
  final List<QueryDocumentSnapshot> documents;
  final int index;
  const GadgetContainer(
      {super.key,
      required this.thisItem,
      required this.documents,
      required this.index});
  static final myGadget = MyGadgetsController();
  static final updateGadget = UpdateController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 180.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: kwhiteColor, borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              MyGadgetImageContainer(
                image: thisItem[firstImageText],
                size: 150.0,
              ),
              kwidth10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thisItem[titleInMapText],
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  kheight10,
                  Text(
                    "Rs.${thisItem['dayPrice']}/day",
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  kheight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.0,
                        child: ElevatedButton(
                            onPressed: () async {
                              final itemMap = await updateGadget.itemMap(
                                  doc: documents[index].id);
                              if (itemMap != null) {
                           
                                Get.to(() => UpdateGadget(
                                      itemMap: itemMap,
                                      doc: documents[index].id,
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kgrey,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: const Text(
                              editGadgetText,
                              style: TextStyle(
                                  color: kwhiteColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.dialog(AlertDialog(
                              title: const Text(warningText),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      myGadget.deleteGadget(
                                          doc: documents[index].id);
                                      Get.back();
                                    },
                                    child: const Text(confirmText)),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(cancelText))
                              ],
                            ));
                          },
                          iconSize: 27.0,
                          color: kredColor,
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        kheight20
      ],
    );
  }
}

class MyGadgetImageContainer extends StatelessWidget {
  final double? size;
  final String image;
  const MyGadgetImageContainer({super.key, required this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(image,
          fit: BoxFit.cover, height: size ?? 100.0, width: size ?? 100.0,
          loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Container(
              decoration: BoxDecoration(
                color: kgrey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: size ?? 100.0,
              height: size ?? 100.0,
              child: Center(
                child: BlurHash(
                  imageFit: BoxFit.cover,
                  duration: const Duration(seconds: 4),
                  curve: Curves.bounceInOut,
                  hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                  image: image,
                ),
              ));
        }
      }, errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: BoxDecoration(
            color: kgrey,
            borderRadius: BorderRadius.circular(20.0),
          ),
          width: size ?? 100.0,
          height: size ?? 100.0,
          child: const Center(
            child: Icon(
              Icons.error,
              color: kwhiteColor,
              size: 30.0,
            ),
          ),
        );
      }),
    );
  }
}
