import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/paidmodel/paidgadgetmodel.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/homepage/orders/order_controller.dart';
import 'package:rentease/view/homepage/orders/widget/order_container.dart';

class OrderSCreen extends GetView<OrderController> {
  const OrderSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: StreamBuilder(
        stream: controller.orderStream,
        builder: (_, snapshot) {
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
            if (items.isNotEmpty) {
              return _buildOrderList(items, documents);
            }
          }
          return _buildEmpty();
        },
      ),
    );
  }

  ListView _buildOrderList(
    List<Map<String, dynamic>> items,
    List<QueryDocumentSnapshot<Object?>> documents,
  ) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        controller.order = MyOrderModel.fromSnapshot(documents[index]);

        return const OrderContainer();
      },
    );
  }

  Center _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.upload,
            color: kblackColor,
            size: 25.0,
          ),
          Text(
            "No orders yet",
            style: TextStyle(
                fontSize: 20.0,
                color: kblackColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
