import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:rentease/model/homemodel/gadgets.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/homepage/home/itemscreen/item_screen.dart';
import 'package:rentease/view/homepage/home/widget/item_container.dart';

class StreamBuilderWidget extends StatelessWidget {
  final String category;
  const StreamBuilderWidget({super.key, required this.category});

 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: category == 'All'
            ? FirebaseFirestore.instance.collection(appName).snapshots()
            : FirebaseFirestore.instance
                .collection(appName)
                .where('category', isEqualTo: category)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Some error occured ${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

            if (documents.isEmpty) {
              return const Center(
                child: Text(noGadgetsText,
                    style: TextStyle(color: kblackColor, fontSize: 18.0)),
              );
            }
            List<Map<String, dynamic>> items =
                documents.map((e) => e.data() as Map<String, dynamic>).toList();
            if (items.isEmpty) {
              return const Center(
                child: Text(noGadgetsText,
                    style: TextStyle(color: kblackColor, fontSize: 18.0)),
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final gadget = Gadgets.fromSnapshot(documents[index]);

                return InkWell(
                  onTap: () => Get.to(() => ItemScreen(
                        gadget: gadget,
                        doc: documents[index].id,
                      )),
                  child: ItemContainer(
                    gadget: gadget,
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
