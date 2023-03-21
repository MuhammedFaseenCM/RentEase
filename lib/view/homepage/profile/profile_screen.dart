import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/fetch_profile_details.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/logout_button.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/widget/edit_profile.dart';
import 'package:rentease/view/homepage/profile/widget/listtile_widget.dart';
import 'package:rentease/view/homepage/profile/widget/my_gadgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static ProfileControl profile = ProfileControl();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: profile.docRef
            .doc(FirebaseAuth.instance.currentUser!.email.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("something went wrong"),
            );
          }
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            return Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: boxDecoration,
                child: Column(
                  children: [
                    kheight20,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        color: kwhiteColor,
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                    kheight10,
                    Text(
                      data!["name"] ?? "Name not available",
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: kwhiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    kheight10,
                    Text(
                      data["email"] ??
                          "${FirebaseAuth.instance.currentUser!.email}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: kwhiteColor,
                      ),
                    ),
                    kheight20,
                    SizedBox(
                      width: 200.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const EditProfile());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kwhiteColor,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text(
                            "Edit profile",
                            style: TextStyle(color: kblackColor),
                          )),
                    ),
                    kheight20,
                    ListTileWidget(
                      title: "My Gadgets",
                      icon: Icons.local_grocery_store_rounded,
                      onTap: () {
                        Get.to(() => const MyGadgetsScreen());
                      },
                    ),
                    kheight20,
                    ListTileWidget(
                      title: "Terms and Policies",
                      icon: Icons.assignment,
                      onTap: () {},
                    ),
                    kheight20,
                    ListTileWidget(
                      title: "About",
                      icon: Icons.info,
                      onTap: () {},
                    ),
                    kheight20,
                    kheight20,
                    const LogoutButton()
                  ],
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            );
          }
        });
  }
}
