import 'package:flutter/material.dart';
import 'package:rentease/main.dart';
import 'package:rentease/view/core/appbar_widget.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/loginpage/widgets/login_page_widget.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(title: StringConsts.appName),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: boxDecoration,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: const [HeaderSection(), LoginSection()],
            ),
          ),
        ),
      ),
    );
  }
}
