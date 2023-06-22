
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/homemodel/home_model.dart';
import 'package:rentease/view/core/logout_button.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/profile/screens/booking_screen.dart';
import 'package:rentease/view/homepage/profile/screens/mygadgetscreen/my_gadget_screen.dart';
import 'package:rentease/view/homepage/profile/screens/terms_n_policy_screen.dart';
import 'package:rentease/view/homepage/profile/widget/about_us_widget.dart';
import 'package:rentease/view/homepage/profile/widget/listtile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DrawerWidget extends StatelessWidget {
  final String email;
  const DrawerWidget({super.key, required this.email});
  static final HomeGetx controller = Get.put(HomeGetx());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 80.0,
          ),
          const Text(
            signedAsText,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            email,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          kheight10,
          kheight20,
          ListTileWidget(
            height: 50.0,
            title: AppLocalizations.of(context)!.home,
            icon: Icons.home,
            onTap: () {
              controller.selectedIndex.value = 0;
              Get.back();
            },
          ),
          kheight10,
          ListTileWidget(
            height: 50.0,
            title: AppLocalizations.of(context)!.addItem,
            icon: Icons.add,
            onTap: () {
              controller.selectedIndex.value = 1;
              Get.back();
            },
          ),
          kheight10,
          ListTileWidget(
            height: 50.0,
            title: AppLocalizations.of(context)!.notification,
            icon: Icons.notifications,
            onTap: () {
              controller.selectedIndex.value = 2;
              Get.back();
            },
          ),
          kheight10,
          ListTileWidget(
            height: 50.0,
            title: AppLocalizations.of(context)!.myGadget,
            icon: Icons.local_grocery_store_rounded,
            onTap: () {
              Get.to(() => const MyGadgetsScreen());
            },
          ),
          kheight10,
          ListTileWidget(
            height: 50.0,
            title: AppLocalizations.of(context)!.myBookings,
            icon: Icons.menu_book_outlined,
            onTap: () {
              Get.to(() => const MyBookingScreen());
            },
          ),
          kheight10,
          ListTileWidget(
            height: 50.0,
            title: AppLocalizations.of(context)!.account,
            icon: Icons.person,
            onTap: () {
              controller.selectedIndex.value = 4;
              Get.back();
            },
          ),
          kheight10,
          ListTileWidget(
            height: 50.0,
            title: AppLocalizations.of(context)!.termsAndPolicies,
            icon: Icons.assignment,
            onTap: () {
              Get.to(() => const TermsAndPoliciesScreen());
            },
          ),
          kheight10,
          ListTileWidget(
            height: 50.0,
            title: AppLocalizations.of(context)!.about,
            icon: Icons.info,
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return const AboutUsWidget();
                },
              );
            },
          ),
          kheight20,
          const LogoutButton(),
          kheight10
        ],
      ),
    );
  }
}
