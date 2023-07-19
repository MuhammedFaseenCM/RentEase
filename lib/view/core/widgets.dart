import 'package:flutter/material.dart';
import 'package:rentease/model/languagemodel/lang_model.dart';

import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/localization/l10n.dart';

const kheight20 = SizedBox(
  height: 20,
);
const kheight10 = SizedBox(
  height: 10.0,
);
const kheight5 = SizedBox(
  height: 5.0,
);
const kwidth10 = SizedBox(
  width: 10.0,
);
const kwidth20 = SizedBox(
  width: 20.0,
);

Widget kDivider(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 5.0,
    color: kgreylight,
  );
}

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kblackColor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes the position of the shadow
          ),
        ],
        color: korangeColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
      ),
    );
  }
}

// class LanguagePickerWidget extends StatelessWidget {
//   const LanguagePickerWidget({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<LocaleProvider>(context, listen: false);
//     final locale = provider.locales;
//     return DropdownButtonHideUnderline(
//         child: DropdownButton(
//       value: locale,
//       items: L10n.all.map(
//         (locales) {
//           final lang = L10n.getFlag(locales.languageCode);
//           return DropdownMenuItem(
//             value: locales,
//             onTap: () {
//               final provider =
//                   Provider.of<LocaleProvider>(context, listen: false);
//               provider.setLocale(locales);
//             },
//             child: Text(lang),
//           );
//         },
//       ).toList(),
//       onChanged: (value) {
//         final provider = Provider.of<LocaleProvider>(context, listen: false);
//         provider.setLocale(Locale(value.toString()));
//         print(value.toString());
//       },
//     ));
//   }
// }
