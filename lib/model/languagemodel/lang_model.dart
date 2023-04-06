import 'package:flutter/material.dart';
import 'package:rentease/view/localization/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = L10n.all[3];

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null as Locale;
    notifyListeners();
  }
}
