import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/homemodel/home_model.dart';
import 'package:rentease/view/chats/chat_screen.dart';
import 'package:rentease/view/core/animation.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/additem/additem_screen.dart';
import 'package:rentease/view/homepage/home/home_screen.dart';
import 'package:rentease/view/homepage/notification/notifiy_screen.dart';
import 'package:rentease/view/homepage/orders/order_screen.dart';
import 'package:rentease/view/homepage/profile/profile_screen.dart';
import 'package:rentease/view/homepage/widget/bottomnavigationbar_widget.dart';
import 'package:rentease/view/homepage/drawer/drawer_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

final HomeGetx controller = Get.put(HomeGetx());

class MainScreen extends StatelessWidget {
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
                    Navigator.push(
                      context,
                      SlideRightToLeftPageRoute(
                        builder: (context) => const ChatScreen(),
                        settings: const RouteSettings(name: '/my-new-page'),
                      ),
                    );

                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const ChatScreen(),
                    // ));
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
