import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/widget/add_address.dart';
import 'package:rentease/view/homepage/profile/widget/edit_address.dart';

class SavedAddresses extends StatelessWidget {
  const SavedAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child:
            AppBarWidget(title: AppLocalizations.of(context)!.savedAddresses),
      ),
      body: Column(
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
                        return Container(
                          margin: const EdgeInsets.only(
                              bottom: 20.0, left: 10.0, right: 10.0),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kheight10,
                                    Text(
                                      'Address ${index + 1} ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    kheight10,
                                    Row(
                                      children: [
                                        const Text('House no/name : '),
                                        Text(
                                          address[index]['houseNo']!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    kheight10,
                                    Row(
                                      children: [
                                        const Text('Area/Road : '),
                                        Text(
                                          address[index]['area']!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    kheight10,
                                    Row(
                                      children: [
                                        const Text('City : '),
                                        Text(
                                          address[index]['city']!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    kheight10,
                                    Row(
                                      children: [
                                        const Text('Pincode : '),
                                        Text(
                                          address[index]['pincode']!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    kheight10,
                                    Row(
                                      children: [
                                        const Text('State : '),
                                        Text(
                                          address[index]['state']!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    kheight10,
                                  ]),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.to(() => EditAddressScreen(
                                              isEditAddress: true,
                                              addressMap: address[index],
                                              index: index,
                                            ));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: kBlue900,
                                      )),
                                  kheight10,
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete,
                                        color: kredColor,
                                      ))
                                ],
                              )
                            ],
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
                icon: Icon(
                  Icons.home,
                  color: kOrange900,
                ),
                label: Text(
                  "Add new address",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: kOrange900),
                )),
          ),
          kheight20
        ],
      ),
    );
  }
}
