import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rentease/model/ordermodel/order_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/widget/image_widget.dart';

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
                            //  orderModel.setRating(value);
                            await orderModel.collection
                                .doc(
                                    "${FirebaseAuth.instance.currentUser!.email.toString()}_${orderMap['title']}")
                                .set({
                              'rating': value,
                              'ownerEmail': orderMap['ownerEmail'],
                              'title': orderMap[titleInMapText]
                            });
                            Get.snackbar(
                              "Thanks for the rating",
                              "",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          unratedColor: Colors.grey[350],
                          itemSize: 30.0,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Write a review"))
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
