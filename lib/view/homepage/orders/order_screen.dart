import 'package:flutter/material.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/string_consts.dart';

class OrderSCreen extends StatelessWidget {
  const OrderSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: boxDecoration,
      child: Center(
        child: Text(ordersText),
      ),
    );
  }
}
