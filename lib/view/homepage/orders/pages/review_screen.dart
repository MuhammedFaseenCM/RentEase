import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/widget/image_widget.dart';
import 'package:rentease/view/homepage/orders/pages/review_controller.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({super.key});

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
                ReqImageWidget(imageUrl: controller.order.image1),
                kwidth10,
                Text(
                  controller.order.title,
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
              controller: controller.reviewController,
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
                    onPressed: () {
                      controller.addReview(
                        title: controller.order.title,
                        reviewController: controller.reviewController,
                        ownerEmail: controller.order.ownerEmail,
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
