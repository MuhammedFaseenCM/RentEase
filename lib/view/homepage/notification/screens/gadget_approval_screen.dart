import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/acceptmodel/accept_model.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/homepage/notification/notify_controller.dart';
import 'package:rentease/view/homepage/notification/widget/accept_container.dart';

class GadgetApprovalScreen extends GetView<NotifyController> {
  const GadgetApprovalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: StreamBuilder(
        stream: controller.resStream,
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
            if (items.isNotEmpty) {
              return _buildNotifyList(items, documents);
            }
          }
          return _buildEmpty();
        },
      ),
    );
  }

  ListView _buildNotifyList(
    List<Map<String, dynamic>> items,
    List<QueryDocumentSnapshot<Object?>> documents,
  ) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final response = SendAcceptModel.fromSnapshot(documents[index]);
        return AcceptContainer(
          docId: documents[index].id,
          sendAccept: response,
        );
      },
    );
  }

  Center _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications,
            color: kblackColor,
            size: 25.0,
          ),
          Text(
            "No notification yet",
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
