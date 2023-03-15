import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentease/view/core/button_widget.dart';
import 'package:rentease/controller/signout/signout_function.dart';

class DrawerWidget extends StatelessWidget {
  final String email;
  const DrawerWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Signed In as",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            email,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ButtonWidget(
              color: Colors.blueGrey,
              text: "Logout",
              onpressed: (context) {
                signOutFunc(context: context);
              })
        ],
      ),
    );
  }
}
