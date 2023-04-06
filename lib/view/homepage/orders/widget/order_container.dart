import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rentease/model/ordermodel/order_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/home/itemscreen/widget/review_widget.dart';
import 'package:rentease/view/homepage/notification/widget/image_widget.dart';
import 'package:rentease/view/homepage/orders/widget/review_screen.dart';

class OrderContainer extends StatelessWidget {
  final Map<String, dynamic> orderMap;
  const OrderContainer({super.key, required this.orderMap});
  static final OrderModel orderModel = OrderModel();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kheight20,
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 160.0,
            decoration: BoxDecoration(
                color: kwhiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReqImageWidget(imageUrl: orderMap['image1']),
                    kwidth20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderMap['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        kheight5,
                        const Text(
                          "Payment Completed",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15.0),
                        ),
                        RatingBar.builder(
                          initialRating: orderModel.rating,
                          minRating: 1,
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: kOrange900,
                              size: 10.0,
                            );
                          },
                          onRatingUpdate: (value) async {
                            final reviewRatingDoc = orderModel.collection.doc(
                                "${FirebaseAuth.instance.currentUser!.email.toString()}_${orderMap['title']}");

                            reviewRatingDoc.get().then((snapshot) {
                              if (snapshot.exists) {
                                reviewRatingDoc.update({
                                  'rating': value,
                                  'ownerEmail': orderMap['ownerEmail'],
                                  'title': orderMap[titleInMapText]
                                }).catchError((error) {
                                  print(error);
                                });
                              } else {
                                reviewRatingDoc.set({
                                  'rating': value,
                                  'ownerEmail': orderMap['ownerEmail'],
                                  'title': orderMap[titleInMapText]
                                });
                              }
                            });

                            Get.snackbar("Thanks for the rating", "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: kgreenColor,
                                colorText: kwhiteColor);
                          },
                          unratedColor: Colors.grey[350],
                          itemSize: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.to(() => ReviewScreen(
                                        imageUrl: orderMap['image1'],
                                        title: orderMap['title'],
                                        ownerEmail: orderMap['ownerEmail'],
                                      ));
                                },
                                child: const Text("Write a review")),
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(appName)
                                  .where('title', isEqualTo: orderMap['title'])
                                  .where('email',
                                      isEqualTo: orderMap['ownerEmail'])
                                  .snapshots()
                                  .map((querySnapshot) =>
                                      querySnapshot.docs.first),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Show a loading indicator while waiting for the document snapshot
                                  return const CircularProgressIndicator();
                                } else if (!snapshot.hasData) {
                                  // Show a message if the document snapshot is empty
                                  return const Text("No data found");
                                } else {
                                  var docSnapshot = snapshot.data!;
                                  var isReturned =
                                      docSnapshot.get('available') == 'true';
                                  var buttonChild = isReturned
                                      ? const Text("Returned")
                                      : const Text("Return");
                                  var buttonEnabled = !isReturned;
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kOrange900,
                                      side: BorderSide.none,
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: buttonEnabled
                                        ? () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                            try {
                                              await docSnapshot.reference
                                                  .update(
                                                      {'available': 'true'});
                                              Get.snackbar(
                                                "Return info sent to owner ",
                                                "",
                                                backgroundColor: kgreenColor,
                                                colorText: kwhiteColor,
                                              );
                                            } catch (e) {
                                              print(
                                                  "Error updating document: $e");
                                            }
                                            Get.back();
                                          }
                                        : null, // Set the onPressed function to null when the button is disabled
                                    child: buttonChild,
                                  );
                                }
                              },
                            )

                            // ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //         backgroundColor: kOrange900,
                            //         side: BorderSide.none,
                            //         shape: const StadiumBorder()),
                            //     onPressed: () async {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) => const Center(
                            //           child: CircularProgressIndicator(),
                            //         ),
                            //       );
                            //       var querySnapshot = await FirebaseFirestore
                            //           .instance
                            //           .collection(appName)
                            //           .where('title',
                            //               isEqualTo: orderMap['title'])
                            //           .where('email',
                            //               isEqualTo: orderMap['ownerEmail'])
                            //           .get();

                            //       var docSnapshot = querySnapshot.docs.first;
                            //       if (docSnapshot.exists) {
                            //         try {
                            //           docSnapshot.reference
                            //               .update({'available': 'true'}).then(
                            //                   (value) => Get.snackbar(
                            //                       "Return info sent to owner ",
                            //                       "",
                            //                       backgroundColor: kgreenColor,
                            //                       colorText: kwhiteColor));
                            //         } catch (e) {}
                            //       }
                            //       Get.back();
                            //     },
                            //     child: const Text("Return"))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                kheight10,
              ],
            ),
          ),
        ),
        kheight20
      ],
    );
  }
}
