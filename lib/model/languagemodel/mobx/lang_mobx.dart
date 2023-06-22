import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:rentease/view/localization/l10n.dart';

part 'lang_mobx.g.dart';

class LocaleProvider = _LocaleProvider with _$LocaleProvider;

abstract class _LocaleProvider with Store {
  @observable
  late Locale locale;
  //= const Locale("en");

  //Locale get locale => _locale;

  @action
  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    locale = locale;
  }

  @action
  void clearLocale() {
    locale = null as Locale;
  }
}
