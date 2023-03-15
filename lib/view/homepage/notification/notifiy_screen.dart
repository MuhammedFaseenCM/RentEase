import 'package:flutter/material.dart';
import 'package:rentease/main.dart';

class NotifyScreen extends StatelessWidget {
  const NotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      decoration: boxDecoration,
      child: Center(
        child: Text("Notification"),
      ),
    );
  }
}