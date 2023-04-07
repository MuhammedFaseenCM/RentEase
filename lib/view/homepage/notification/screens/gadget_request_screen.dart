import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease/controller/notification/notify_control.dart';
import 'package:rentease/model/addressmodel/address_model.dart';
import 'package:rentease/model/requestmodel/sendreqmodel.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/homepage/notification/widget/req_container.dart';

class GadgetRequestScreen extends StatelessWidget {
  const GadgetRequestScreen({super.key});
  static final notifyControl = NotifyController();
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: StreamBuilder(
        stream: notifyControl.reqStream,
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
            notifyControl.items = documents
                .map((e) => e.data() as Map<String, dynamic>)
                .where((map) =>
                    map['ownerEmail'] ==
                    FirebaseAuth.instance.currentUser!.email.toString())
                .toList();
            if (notifyControl.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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

            return ListView.builder(
              itemCount: notifyControl.items.length,
              itemBuilder: (context, index) {
             
                final address = AddressModel.fromSnapshot(documents[index]);
                final sendReq = SendRequestModel.fromSnapshot(documents[index]);
                return RequestContainer(
                  sendReq: sendReq,
                  address: address,
                 
                  docId: documents[index].id,
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
