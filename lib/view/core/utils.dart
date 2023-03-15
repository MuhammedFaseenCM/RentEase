import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text, {color, textColor,snackPosition}) {
    Get.snackbar(text!, "", backgroundColor: color, colorText: textColor,snackPosition: snackPosition);

    // messengerKey.currentState!
    //   ..removeCurrentSnackBar()
    //   ..sNackBar;
  }
}
