import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/homepage/home/itemscreen/item_screen.dart';
import 'package:rentease/view/homepage/home/widget/item_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static CollectionReference reference =
      FirebaseFirestore.instance.collection("RentEase");

  static Stream<QuerySnapshot> stream = reference.snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: stream,
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
                List<Map> items =
                    documents.map((e) => e.data() as Map).toList();
                if (items.isEmpty) {
                  return const Center(
                    child: Text("Items not available",
                        style: TextStyle(color: kwhiteColor, fontSize: 18.0)),
                  );
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    Map thisItem = items[index];
                    return InkWell(
                      onTap: () => Get.to(() => ItemScreen(
                            itemMap: thisItem,
                          )),
                      child: ItemContainer(
                        image: thisItem['image1'],
                        title: thisItem['title'] ?? "Title not available",
                        perday: thisItem['dayPrice'],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
