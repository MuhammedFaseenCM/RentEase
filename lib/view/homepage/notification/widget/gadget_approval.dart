import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:rentease/controller/notification/notify_control.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/widgets.dart';

class GadgetApproval extends StatelessWidget {
  const GadgetApproval({super.key});
  static final notifyControl = NotifyController();
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: StreamBuilder(
        stream: notifyControl.resStream,
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
          }
          if (snapshot.hasData) {
            QuerySnapshot? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
            List<Map<String, dynamic>> items = documents
                .map((e) => e.data() as Map<String, dynamic>)
                .where((map) =>
                    map['userEmail'] ==
                    FirebaseAuth.instance.currentUser!.email.toString())
                .toList();
            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.notifications,
                      color: kwhiteColor,
                      size: 25.0,
                    ),
                    Text(
                      "No notification yet",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: kwhiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final itemMap = items[index];
                return AcceptContainer(
                  docId: documents[index].id,
                  resMap: itemMap,
                );
              },
            );
          } else {
            return const Center(
              child: Text("No notification yet"),
            );
          }
        },
      ),
    );
  }
}

class AcceptContainer extends StatelessWidget {
  final String docId;
  final Map resMap;
  const AcceptContainer({super.key, required this.docId, required this.resMap});
  static final notifyControl = NotifyController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              height: 180.0,
              decoration: BoxDecoration(
                color: kwhiteColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  kheight10,
                  Text(
                    resMap['status'] == 'accept'
                        ? "${resMap['ownerEmail']} accepted the request"
                        : "${resMap['ownerEmail']} rejected the request",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  kheight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(resMap['image1'],
                            height: 100.0, width: 120.0, fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Container(
                                decoration: BoxDecoration(
                                  color: kgrey,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                width: 120.0,
                                height: 100.0,
                                child: Center(
                                  child: BlurHash(
                                    imageFit: BoxFit.cover,
                                    duration: const Duration(seconds: 4),
                                    curve: Curves.bounceInOut,
                                    hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
                                    image: resMap['image1'],
                                  ),
                                ));
                          }
                        }, errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: kgrey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            width: 120.0,
                            height: 100.0,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resMap['title'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          kheight5,
                          Text(
                            "Rs.${resMap['plan']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15.0),
                          ),
                          resMap['status'] == 'accept'
                              ? SizedBox(
                                  width: 130.0,
                                  child: ElevatedButton(
                                    onPressed: () async {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kBlue900,
                                        side: BorderSide.none,
                                        shape: const StadiumBorder()),
                                    child: const Text(
                                      "Payments",
                                      maxLines: 1,
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  width: 130.0,
                                ),
                          kwidth10,
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: kgrey,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50.0)),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          notifyControl.deleteRes(docId: docId);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: kwhiteColor,
                        )),
                  ),
                ))
          ],
        ),
        kheight20
      ],
    );
  }
}