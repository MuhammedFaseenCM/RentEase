import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/bookgadget/plan_select.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

Future<void> addAddressFunction(
    {required doc,
    required validText,
    required gadget,
    required price,
    required address}) async {
  final selectPlan = SelectPlan();
  Get.dialog(AlertDialog(
    title: const Text(warningText),
    content: Text("You are Selected $rupee$price plan \nfor $validText"),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(cancelText)),
      TextButton(
          onPressed: () async {
            Get.back();
            await selectPlan.sendReq(
                planType: validText,
                price: price,
                gadget: gadget,
                address: address,
                doc: doc);
            Get.dialog(AlertDialog(
              title: Column(
                children: [
                  Icon(
                    Icons.check,
                    size: 120.0,
                    color: kgreenColor,
                  ),
                  const Text(
                    reqSentText,
                    style: TextStyle(),
                  )
                ],
              ),
            ));
            await Future.delayed(const Duration(seconds: 1));
            Get.back();
            Get.back();
            Get.back();
            Get.back();
          },
          child: const Text(confirmText)),
    ],
  ));
}
