import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/signout/signout_function.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 50.0,
      child: ElevatedButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: const Text(warningText),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(cancelText)),
                  TextButton(
                      onPressed: () {
                        signOutFunc(context: context);
                      },
                      child: const Text(logoutText))
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: kredColor,
              side: BorderSide.none,
              shape: const StadiumBorder()),
          child: const Text(
            logoutText,
            style: TextStyle(color: kwhiteColor),
          )),
    );
  }
}
