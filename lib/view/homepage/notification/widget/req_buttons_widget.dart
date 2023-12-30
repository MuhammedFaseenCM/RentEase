import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/model/requestmodel/sendreqmodel.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';
import 'package:rentease/view/homepage/notification/notify_controller.dart';

class ReqButtonsWidget extends GetView<NotifyController> {
  final String docId;
  final SendRequestModel sendreq;
  const ReqButtonsWidget({
    super.key,
    required this.docId,
    required this.sendreq,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sendreq.status == 'waiting'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildResponse(),
                  kwidth10,
                  _buildReject(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150.0,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: sendreq.status == 'accept'
                          ? const Icon(Icons.check)
                          : const Icon(Icons.close),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      label: Text(
                          sendreq.status == 'accept' ? "Accepted" : "Rejected"),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  GetBuilder _buildReject() {
    return GetBuilder<NotifyController>(
      id: NotifyController.reBuildResponse,
      builder: (_) {
        return SizedBox(
          width: 100.0,
          child: ElevatedButton(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: const Text(warningText),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(cancelText)),
                  TextButton(
                      onPressed: () async {
                        await controller.sendResp(
                            docId: docId, sendReq: sendreq, status: "reject");
                        Get.back();
                        Get.snackbar("Rejected", "",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: kgreenColor,
                            colorText: kwhiteColor);
                      },
                      child: const Text(confirmText))
                ],
              ));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: kredColor,
                side: BorderSide.none,
                shape: const StadiumBorder()),
            child: const Text("Reject"),
          ),
        );
      }
    );
  }

  GetBuilder _buildResponse() {
    return GetBuilder<NotifyController>(
        id: NotifyController.reBuildResponse,
        builder: (context) {
          return SizedBox(
              width: 100.0,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.sendResp(
                      docId: docId, sendReq: sendreq, status: "accept");
                  Get.snackbar("Request accepted", "",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: kgreenColor,
                      colorText: kwhiteColor);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kgreenColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text("Accept"),
              ),);
        },);
  }
}
