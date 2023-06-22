import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
    const Locale('hi'),
    const Locale('es'),
    const Locale('de'),
    const Locale('ml'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return 'Arabic';
      case 'en':
        return 'English';
      case 'es':
        return 'Espanol';
      case 'hi':
        return 'Hindi';
      case 'ml':
        return 'മ';

      default:
        return 'English';
    }
  }
}
