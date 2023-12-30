import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rentease/services/routes/route_names.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/widget/image_widget.dart';
import 'package:rentease/view/homepage/orders/order_controller.dart';

class OrderContainer extends GetView<OrderController> {
  const OrderContainer({super.key});
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
            decoration: _boxDec(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReqImageWidget(imageUrl: controller.order.image1),
                    kwidth20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(),
                        kheight5,
                        const Text(
                          "Payment Completed",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15.0),
                        ),
                        _buildRating(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RoutesName.review);
                              },
                              child: const Text(
                                "Write a review",
                              ),
                            ),
                            _buildReturn(),
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

  Text _buildTitle() {
    return Text(
                        controller.order.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      );
  }

  BoxDecoration _boxDec() {
    return BoxDecoration(
            color: kwhiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
            ],
          );
  }

  StreamBuilder<DocumentSnapshot<Object?>> _buildReturn() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection(appName)
          .where('title', isEqualTo: controller.order.title)
          .where('email', isEqualTo: controller.order.ownerEmail)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.first),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the document snapshot
          return const CircularProgressIndicator();
        } else if (!snapshot.hasData) {
          // Show a message if the document snapshot is empty
          return const Text("No data found");
        } else {
          DocumentSnapshot<Object?> docSnapshot = snapshot.data!;
          bool isReturned = docSnapshot.get('available') == 'true';
          Widget buttonChild =
              isReturned ? const Text("Returned") : const Text("Return");
          bool buttonEnabled = !isReturned;
          return _buildReturnButton(
              buttonEnabled, context, docSnapshot, buttonChild);
        }
      },
    );
  }

  GetBuilder _buildReturnButton(
    bool buttonEnabled,
    BuildContext context,
    DocumentSnapshot<Object?> docSnapshot,
    Widget buttonChild,
  ) {
    return GetBuilder<OrderController>(
      id: OrderController.reBuildRating,
      builder: (_) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kOrange900,
            side: BorderSide.none,
            shape: const StadiumBorder(),
          ),
          onPressed: buttonEnabled
              ? () async {
                  controller.returnGadget(
                      context: context, docSnapshot: docSnapshot);
                }
              : null, // Set the onPressed function to null when the button is disabled
          child: buttonChild,
        );
      },
    );
  }

  GetBuilder _buildRating() {
    return GetBuilder<OrderController>(
      id: OrderController.reBuildRating,
      builder: (_) {
        return RatingBar.builder(
          initialRating: controller.rating,
          minRating: 1,
          itemBuilder: (context, index) {
            return Icon(
              Icons.star,
              color: kOrange900,
              size: 10.0,
            );
          },
          onRatingUpdate: (value) async {
            await controller.addRating(value: value);
          },
          unratedColor: Colors.grey[350],
          itemSize: 30.0,
        );
      },
    );
  }
}
