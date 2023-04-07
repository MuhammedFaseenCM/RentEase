import 'package:flutter/material.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:rentease/view/localization/l10n.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child:
            AppBarWidget(title: AppLocalizations.of(context)!.selectLanguage),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final flag = L10n.all[index];
          return Card(
            child: ListTile(
              title: Text(language),
              onTap: () {
                
          
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50.0,
          child: TextButton(
            child: const Text(confirmText),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    );
  }
}

List languages = [
  'English',
  'हिंदी',
  'മലയാളം',
  'español',
  'عربي',
  'deutsch',
];
