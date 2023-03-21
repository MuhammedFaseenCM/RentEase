import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/controller/signout/signout_function.dart';
import 'package:rentease/view/core/const_colors.dart';

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
                title: const Text("Are you sure ?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        signOutFunc(context: context);
                      },
                      child: const Text("Logout"))
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: kredColor,
              side: BorderSide.none,
              shape: const StadiumBorder()),
          child: const Text(
            "Logout",
            style: TextStyle(color: kwhiteColor),
          )),
    );
  }
}
