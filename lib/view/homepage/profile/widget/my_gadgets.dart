import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/mygadgets/mygadgets_control.dart';
import 'package:rentease/controller/update/update_item.dart';
import 'package:rentease/model/homemodel/gadgets.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/widget/update_gadgets.dart';

class MyGadgetsScreen extends StatelessWidget {
  const MyGadgetsScreen({super.key});
  static MyGadgetsController myGadget = MyGadgetsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: myGadgetsText),
        ),
        body: CustomContainer(
          child: StreamBuilder<QuerySnapshot>(
              stream: myGadget.query
                  .where('email',
                      isEqualTo:
                          FirebaseAuth.instance.currentUser!.email.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot? querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

                  if (documents.isEmpty) {
                    return const Center(
                      child: Text(
                        noGadgetsText,
                        style: TextStyle(
                            color: kblackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final gadget = Gadgets.fromSnapshot(documents[index]);

                      return GadgetContainer(
                          gadget: gadget, documents: documents, index: index);
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      wrongText,
                      style: TextStyle(
                          color: kblackColor,
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
  final List<QueryDocumentSnapshot> documents;
  final Gadgets gadget;
  final int index;
  const GadgetContainer(
      {super.key,
      required this.documents,
      required this.index,
      required this.gadget});
  static final myGadget = MyGadgetsController();
  static final updateGadget = UpdateController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight20,
        Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(5.0),
          height: 140.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: kwhiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
              ]),
          child: Row(
            children: [
              MyGadgetImageContainer(
                image: gadget.image1,
                size: 100.0,
              ),
              kwidth20,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kheight20,
                    Text(
                      gadget.title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    kheight10,
                    Text(
                      "Rs.${gadget.dayPrice}/day",
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                    kheight10,
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
                                        gadget: gadget,
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
              ),
            ],
          ),
        ),
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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
          ]),
      child: ClipRRect(
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
      ),
    );
  }
}
