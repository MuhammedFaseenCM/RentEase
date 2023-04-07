import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/additem/add_item_fun.dart';
import 'package:rentease/controller/bookgadget/add_address_fun.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/screens/address_screen/add_address_screen.dart';

void showAddressSheet(
    {required BuildContext context,
    bool isAddItem = false,
    doc,
    validText,
    gadget,
    price}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        height: 500.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kheight20,
            const Center(
              child: Text(
                'Select your address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            kheight20,
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic>? documents = snapshot.data!.data();
                  if (documents!['addresses'] == null) {
                    return const Center(child: Text("Add address"));
                  }
                  List<dynamic> address =
                      (documents['addresses'] as List<dynamic>);

                  if (address.isEmpty) {
                    return const Center(child: SizedBox());
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: address.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              isAddItem == true
                                  ? addAddressForItemFunction(
                                      address: address[index])
                                  : addAddressFunction(
                                      doc: doc,
                                      validText: validText,
                                      gadget: gadget,
                                      price: price,
                                      address: address[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20.0),
                              padding: const EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                        spreadRadius: 2.0)
                                  ],
                                  border: Border.all(color: Colors.grey),
                                  color: kwhiteColor),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kheight10,
                                    Text(address[index]['houseNo']!),
                                    kheight10,
                                    Text(address[index]['area']!),
                                    kheight10,
                                    Text(address[index]['city']!),
                                    kheight10,
                                    Text(address[index]['pincode']!),
                                    kheight10,
                                    Text(address[index]['state']!),
                                    kheight10,
                                  ]),
                            ),
                          );
                        }),
                  );
                } else {
                  return const Center(
                    child: Text("Add address"),
                  );
                }
              },
            ),
            Center(
              child: TextButton.icon(
                  onPressed: () {
                    Get.to(() => const AddAddressWidget());
                  },
                  icon: const Icon(Icons.home),
                  label: const Text("Add new address")),
            )
          ],
        ),
      );
    },
  );
}
