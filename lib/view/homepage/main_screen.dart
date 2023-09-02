import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/services/routes/route_names.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/homepage/additem/additem_screen.dart';
import 'package:rentease/view/homepage/home/home_screen.dart';
import 'package:rentease/view/homepage/main_controller.dart';
import 'package:rentease/view/homepage/notification/notifiy_screen.dart';
import 'package:rentease/view/homepage/orders/order_screen.dart';
import 'package:rentease/view/homepage/profile/profile_screen.dart';
import 'package:rentease/view/homepage/widget/bottomnavigationbar_widget.dart';
import 'package:rentease/view/homepage/drawer/drawer_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        drawer: DrawerWidget(email: user.email!),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(
            isHome: true,
            title: AppLocalizations.of(context)!.appName,
            actions: [
              //   const LanguagePickerWidget(),
              IconButton(
                  onPressed: () {
                    Get.toNamed(RoutesName.chat);
                  },
                  icon: const Icon(Icons.message))
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
        body: Obx(() {
          return IndexedStack(
              index: controller.selectedIndex.value,
              children: const [
                HomeScreen(),
                AddItemScreen(),
                NotifyScreen(),
                OrderSCreen(),
                ProfileScreen()
              ]);
        }));
  }
}
