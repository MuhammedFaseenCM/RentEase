import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/signuppage/signup_screen.dart';

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          showCountryPicker(
            context: context,
            countryListTheme:
                const CountryListThemeData(bottomSheetHeight: 500),
            onSelect: (value) {
              country = value;
            },
          );
        },
        child: Text(
          "${country.flagEmoji}  +${country.phoneCode}",
          style: const TextStyle(
              fontSize: 15, color: kblackColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}