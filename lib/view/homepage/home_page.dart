import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentease/model/homemodel/home_model.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/homepage/additem/additem_screen.dart';
import 'package:rentease/view/homepage/home/home_screen.dart';
import 'package:rentease/view/homepage/notification/notifiy_screen.dart';
import 'package:rentease/view/homepage/orders/order_screen.dart';
import 'package:rentease/view/homepage/profile/profile_screen.dart';
import 'package:rentease/view/homepage/widget/bottomnavigationbar_widget.dart';
import 'package:rentease/view/homepage/widget/drawer_widget.dart';

final HomeGetx controller = Get.put(HomeGetx());

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return Scaffold(
        drawer: DrawerWidget(email: user.email!, googleSignIn: googleSignIn),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: StringConsts.appName),
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

const pages = [
  HomeScreen(),
  AddItemScreen(),
  NotifyScreen(),
  OrderSCreen(),
  ProfileScreen()
];
