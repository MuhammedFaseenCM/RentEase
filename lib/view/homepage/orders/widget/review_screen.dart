import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/ordermodel/order_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/widget/image_widget.dart';

class ReviewScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String ownerEmail;
  const ReviewScreen(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.ownerEmail});
  static final OrderModel orderModel = OrderModel();
  static TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(
          title: "Review Gadget",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kheight20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ReqImageWidget(imageUrl: imageUrl),
                kwidth10,
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            kheight20,
            const Text(
              "Write a review",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            kheight10,
            TextFormField(
              controller: reviewController,
              decoration: const InputDecoration(
                  labelText: "Review",
                  border: OutlineInputBorder(),
                  hintText:
                      "How is the gadget? What do you like? What do you hate?",
                  hintStyle: TextStyle(fontSize: 12.0)),
              //minLines: 5,
              maxLines: 6,
            ),
            kheight20,
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 160.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide.none, shape: const StadiumBorder()),
                    onPressed: () async {
                      Get.dialog(
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      final reviewRatingDoc = orderModel.collection.doc(
                          "${FirebaseAuth.instance.currentUser!.email.toString()}_$title");
                      await reviewRatingDoc.get().then((snapshot) {
                        if (snapshot.exists) {
                          reviewRatingDoc.update({
                            'review': reviewController.text,
                            'ownerEmail': ownerEmail,
                            'title': title
                          }).catchError((error) {
                            print(error);
                          });
                        } else {
                          reviewRatingDoc.set({
                            'review': reviewController.text,
                            'ownerEmail': ownerEmail,
                            'title': title
                          });
                        }
                      });

                      Get.back();
                      Get.back();

                      Get.snackbar(
                        "Thanks for your valuable time",
                        "",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: const Text("Finish")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
