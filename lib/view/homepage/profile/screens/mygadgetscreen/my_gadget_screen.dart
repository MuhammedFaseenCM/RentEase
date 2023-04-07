import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentease/controller/profile/mygadgets/mygadgets_control.dart';
import 'package:rentease/model/homemodel/gadgets.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/homepage/profile/widget/gadget_container.dart';

class MyGadgetsScreen extends StatelessWidget {
  const MyGadgetsScreen({super.key});
  static MyGadgetsController myGadget = MyGadgetsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: myGadgetsText),
        ),
        body: CustomContainer(
          child: StreamBuilder<QuerySnapshot>(
              stream: myGadget.query
                  .where('email',
                      isEqualTo:
                          FirebaseAuth.instance.currentUser!.email.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot? querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

                  if (documents.isEmpty) {
                    return const Center(
                      child: Text(
                        noGadgetsText,
                        style: TextStyle(
                            color: kblackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final gadget = Gadgets.fromSnapshot(documents[index]);

                      return GadgetContainer(
                          gadget: gadget, documents: documents, index: index);
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      wrongText,
                      style: TextStyle(
                          color: kblackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
  }
}