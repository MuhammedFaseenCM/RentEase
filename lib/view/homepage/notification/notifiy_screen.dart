import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/homepage/notification/notify_controller.dart';
import 'package:rentease/view/homepage/notification/screens/gadget_approval_screen.dart';
import 'package:rentease/view/homepage/notification/screens/gadget_request_screen.dart';

class NotifyScreen extends GetView<NotifyController> {
  const NotifyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    controller.notfyIconController = false;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar(),
        body: const TabBarView(
          children: [
            GadgetRequestScreen(),
            GadgetApprovalScreen(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: kwhiteColor,
      bottom: _tabBar(),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      isScrollable: true,
      labelColor: kwhiteColor,
      labelStyle: kTextStyle,
      unselectedLabelColor: kblackColor,
      unselectedLabelStyle: kTextStyle,
      tabs: const [
        Tab(child: Text("Rental Requests")),
        Tab(child: Text("Rental approvals")),
      ],
      indicator: BoxDecoration(
        color: kbluegreyColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}
