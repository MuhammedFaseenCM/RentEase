import 'package:flutter/material.dart';
import 'package:rentease/controller/notification/notify_control.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/homepage/notification/screens/gadget_approval_screen.dart';
import 'package:rentease/view/homepage/notification/screens/gadget_request_screen.dart';

class NotifyScreen extends StatelessWidget {
  const NotifyScreen({super.key});
  static final notifyControl = NotifyController();
  @override
  Widget build(BuildContext context) {
    notifyControl.notfyIconController = false;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kwhiteColor,
            bottom: TabBar(
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
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          ),
          body: const TabBarView(children: [
            GadgetRequestScreen(),
            GadgetApprovalScreen(),
          ])),
    );
  }
}


