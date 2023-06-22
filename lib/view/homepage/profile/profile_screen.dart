import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/profile/fetch_profile_details.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/logout_button.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/screens/booking_screen.dart';
import 'package:rentease/view/homepage/profile/screens/edit_profile_screen.dart';
import 'package:rentease/view/homepage/profile/screens/mygadgetscreen/my_gadget_screen.dart';
import 'package:rentease/view/homepage/profile/screens/terms_n_policy_screen.dart';
import 'package:rentease/view/homepage/profile/widget/about_us_widget.dart';
import 'package:rentease/view/homepage/profile/widget/listtile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:rentease/view/homepage/profile/screens/address_screen/saved_addresses.dart';

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
              child: Text(wrongText),
            );
          }
          if (snapshot.hasData) {
            DocumentSnapshot<Map<String, dynamic>>? querySnapshot =
                snapshot.data;
            Map<String, dynamic>? data = querySnapshot!.data();
            print(data);

            //var data = snapshot.data!.data();
            // if (data==null) {
            //   print(data.toString());
            //   return const Center(
            //   child: Text(wrongText),
            // );
            // }

            return Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: boxDecoration,
                child: Column(
                  children: [
                    kheight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcome.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: kOrange900,
                              fontWeight: FontWeight.bold),
                        ),
                        kwidth10,
                        Flexible(
                          child: Text(
                            data![nameInMapText] ?? nameNullText,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: kblackColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    kheight10,
                    Text(
                      data[emailInMapText] ??
                          "${FirebaseAuth.instance.currentUser!.email}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: kblackColor,
                      ),
                    ),
                    kheight20,
                    SizedBox(
                      width: 230.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const EditProfile());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kOrange900,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: Text(
                            AppLocalizations.of(context)!.editProfile,
                            maxLines: 1,
                            style: const TextStyle(color: kwhiteColor),
                          )),
                    ),
                    kheight20,
                    ListTileWidget(
                      title: AppLocalizations.of(context)!.myGadget,
                      icon: Icons.local_grocery_store_rounded,
                      onTap: () {
                        Get.to(() => const MyGadgetsScreen());
                      },
                    ),
                    kheight20,
                    // ListTileWidget(
                    //   title: AppLocalizations.of(context)!.selectLanguage,
                    //   icon: Icons.assignment,
                    //   onTap: () {
                    //     Get.to(() => const SelectLanguageScreen());
                    //   },
                    // ),
                    ListTileWidget(
                      title: AppLocalizations.of(context)!.myBookings,
                      icon: Icons.menu_book_outlined,
                      onTap: () {
                        Get.to(() => const MyBookingScreen());
                      },
                    ),
                    kheight20,
                    ListTileWidget(
                      title: AppLocalizations.of(context)!.savedAddresses,
                      icon: Icons.location_on,
                      onTap: () {
                        Get.to(() => const SavedAddresses());
                      },
                    ),
                    kheight20,
                    ListTileWidget(
                      title: AppLocalizations.of(context)!.termsAndPolicies,
                      icon: Icons.assignment,
                      onTap: () {
                        Get.to(() => const TermsAndPoliciesScreen());
                      },
                    ),
                    kheight20,
                    ListTileWidget(
                      title: AppLocalizations.of(context)!.about,
                      icon: Icons.info,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AboutUsWidget();
                          },
                        );
                      },
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
