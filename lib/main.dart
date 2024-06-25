import 'dart:ui';

import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const ProductListScreen(),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: CustomColors.blue,
                                spreadRadius: -7,
                                blurRadius: 20,
                                offset: Offset(0, 13)),
                          ],
                        ),
                        child: Image.asset('assets/images/icon_home.png')),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_home.png'),
                    label: 'a'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_home.png'),
                    label: 'b'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_home.png'),
                    label: 'c'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
