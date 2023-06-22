import 'package:flutter/material.dart';
import 'package:rentease/view/core/const_colors.dart';
import 'package:rentease/view/core/string_consts.dart';
import 'package:rentease/view/homepage/home/widget/streambuilder_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: allCategories(context: context).length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kwhiteColor,
          //Colors.orange[900],
          bottom: TabBar(
              isScrollable: true,
              labelColor: kblackColor,
              labelStyle: kTextStyle,
              unselectedLabelColor: kblackColor,
              unselectedLabelStyle: unselectedTextStyle,
              tabs: List.generate(
                  allCategories(context: context).length,
                  (index) => Tab(
                      child: Text(allCategories(context: context)[index])))),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            allCategories(context: context).length,
            (index) => StreamBuilderWidget(category: allcategories[index]),
          ),
        ),
      ),
    );
  }
}
