import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/bookgadget/plan_select.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/screen_container_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';

class SelectPlanScreen extends StatelessWidget {
  final Map<String, dynamic> itemMap;
  const SelectPlanScreen({super.key, required this.itemMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: appName),
      ),
      body: CustomContainer(
          child: Column(
        children: [
          const Text(
            selectPlanText,
            style: TextStyle(
                fontSize: 25.0,
                color: kwhiteColor,
                fontWeight: FontWeight.bold),
          ),
          kheight20,
          PlanContainerWidget(
            planDetails: dayPlanDetailsText,
            planTypeText: dailyPlanText,
            validText: oneDayText,
            priceText: itemMap[dayPriceInMapText],
            itemMap: itemMap,
          ),
          kheight20,
          PlanContainerWidget(
            planDetails: weekPlanDetailsText,
            planTypeText: weeklyPlanText,
            validText: sevenWeekText,
            priceText: itemMap[weekPriceInMapText],
            itemMap: itemMap,
          ),
          kheight20,
          PlanContainerWidget(
            planDetails: monthPlanDetailsText,
            planTypeText: monthlyPlanText,
            validText: oneMonthText,
            priceText: itemMap[monthPriceInMapText],
            itemMap: itemMap,
          ),
          kheight20,
        ],
      )),
    );
  }
}

class PlanContainerWidget extends StatelessWidget {
  final Map itemMap;
  final String planDetails;
  final String planTypeText;
  final String validText;
  final String priceText;
  const PlanContainerWidget({
    super.key,
    required this.itemMap,
    required this.planDetails,
    required this.planTypeText,
    required this.priceText,
    required this.validText,
  });
  static final selectPlan = SelectPlan();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(AlertDialog(
          title: const Text(warningText),
          content: Text("You are Selected Rs.$priceText plan \nfor $validText"),
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
                      planType: validText, price: priceText, itemMap: itemMap);
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
                },
                child: const Text(confirmText)),
          ],
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.hardEdge,
        height: 200,
        decoration: BoxDecoration(
            color: kwhiteColor, borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planTypeText,
                  style: const TextStyle(
                      fontSize: 23.0, fontWeight: FontWeight.bold),
                ),
                kheight10,
                Text(planDetails)
              ],
            ),
            SizedBox(
              width: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: kblackColor,
                    height: 200,
                    width: 1.0,
                  ),
                  kwidth10,
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rs.$priceText",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(validText)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
