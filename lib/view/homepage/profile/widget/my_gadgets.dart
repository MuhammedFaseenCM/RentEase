import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/mygadgets/mygadgets_control.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/widget/update_gadgets.dart';

class MyGadgetsScreen extends StatelessWidget {
  const MyGadgetsScreen({super.key});
  static final myGadget = MyGadgetsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: "My Gadgets"),
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
                  List<Map> items = documents
                      .map((e) => e.data() as Map)
                      .where((map) =>
                          map['email'] ==
                          FirebaseAuth.instance.currentUser!.email.toString())
                      .toList();
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      Map thisItem = items[index];
                      if (items.isEmpty) {
                        return const Center(
                          child: Text(
                            "You have no gadgets",
                            style: TextStyle(
                                color: kwhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            height: 180.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: kwhiteColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    thisItem['image1'],
                                    fit: BoxFit.cover,
                                    height: 150.0,
                                    width: 150.0,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.error),
                                      );
                                    },
                                  ),
                                ),
                                kwidth10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      thisItem['title'],
                                      style: const TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kheight10,
                                    Text(
                                      "Rs.${thisItem['dayPrice']}/day",
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    kheight20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.0,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Get.to(
                                                    () => const UpdateGadget());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: kgrey,
                                                  side: BorderSide.none,
                                                  shape: const StadiumBorder()),
                                              child: const Text(
                                                "Edit gadget",
                                                style: TextStyle(
                                                    color: kwhiteColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                title: Text(
                                                    "Are you sure want to delete?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        myGadget.deleteGadget(
                                                            doc:
                                                                documents[index]
                                                                    .id);
                                                        Get.back();
                                                      },
                                                      child: Text("Confirm")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text("Cancel"))
                                                ],
                                              ));
                                              log(documents[index].id);
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
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Something went wrong!",
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
