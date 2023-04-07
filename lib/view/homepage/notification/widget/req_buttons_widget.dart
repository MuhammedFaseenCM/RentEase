import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/notification/notify_control.dart';
import 'package:rentease/model/requestmodel/sendreqmodel.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/core/widgets.dart';

class ReqButtonsWidget extends StatelessWidget {
  final String docId;
  final SendRequestModel sendreq;
  const ReqButtonsWidget(
      {super.key, required this.docId, required this.sendreq});
  static final notifyControl = NotifyController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sendreq.status == 'waiting'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 100.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          await notifyControl.sendResp(
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
                      )),
                  kwidth10,
                  SizedBox(
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
                                  await notifyControl.sendResp(
                                      docId: docId,
                                      sendReq: sendreq,
                                      status: "reject");
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
                  ),
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
}
