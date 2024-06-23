import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/widgets/banner_slider.dart';
import 'package:ecommerce/widgets/category_item_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemExtent: 75,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CategoryHorizontalteList();
              },
            ),
          ),
        ),
      ),
    );
  }
}

