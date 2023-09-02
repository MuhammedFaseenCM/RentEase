import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentease/view/splash_screen/splash_controller.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: 
        Image(image: AssetImage('asset/images/launcher-removebg.png')),
      ),
    );
  }
}
