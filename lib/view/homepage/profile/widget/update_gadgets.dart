import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/homepage/additem/additem_screen.dart';

class UpdateGadget extends StatelessWidget {
  const UpdateGadget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: StringConsts.appName),
      ),
      body: AddItemScreen(),
    );
  }
}
