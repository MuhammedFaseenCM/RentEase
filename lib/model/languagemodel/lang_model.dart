import 'package:flutter/material.dart';
import 'package:rentease/view/localization/l10n.dart';

class LocaleProvider extends ChangeNotifier {
   Locale? locales;
  Locale? get locale => locales;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    locales = locale;
    notifyListeners();
  }

  // void clearLocale() {
  //   _locale = null as Locale;
  //   notifyListeners();
  // }
}
