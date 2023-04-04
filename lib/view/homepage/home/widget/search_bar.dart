import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentease/view/core/widgets.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey, //.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: const [
          Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 20.0,
          ),
          kwidth10,
          Text(
            "Search",
            style:
                TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
