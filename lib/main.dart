import 'dart:ui';

import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/screens/category_screen.dart';
import 'package:ecommerce/screens/hom_screen.dart';
import 'package:ecommerce/screens/product_list_screen.dart';
import 'package:ecommerce/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedBottomNavigationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: selectedBottomNavigationIndex,
          children: getScreens(),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  selectedBottomNavigationIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              currentIndex: selectedBottomNavigationIndex,
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                  fontFamily: 'SB', fontSize: 10, color: CustomColors.blue),
              unselectedLabelStyle: const TextStyle(
                  fontFamily: 'SB', fontSize: 10, color: Colors.black),
              items: [
                BottomNavigationBarItem(
                  activeIcon: Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: CustomColors.blue,
                              spreadRadius: -7,
                              blurRadius: 20,
                              offset: Offset(0, 13)),
                        ],
                      ),
                      child:
                          Image.asset('assets/images/icon_profile_active.png')),
                  label: 'حساب کاربری',
                  icon: Image.asset('assets/images/icon_profile.png'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: CustomColors.blue,
                              spreadRadius: -7,
                              blurRadius: 20,
                              offset: Offset(0, 13)),
                        ],
                      ),
                      child:
                          Image.asset('assets/images/icon_basket_active.png')),
                  label: 'سبد خرید',
                  icon: Image.asset('assets/images/icon_basket.png'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: CustomColors.blue,
                              spreadRadius: -7,
                              blurRadius: 20,
                              offset: Offset(0, 13)),
                        ],
                      ),
                      child: Image.asset(
                          'assets/images/icon_category_active.png')),
                  label: 'دسته بندی',
                  icon: Image.asset('assets/images/icon_category.png'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: CustomColors.blue,
                              spreadRadius: -7,
                              blurRadius: 20,
                              offset: Offset(0, 13)),
                        ],
                      ),
                      child: Image.asset('assets/images/icon_home_active.png')),
                  label: 'خانه',
                  icon: Image.asset('assets/images/icon_home.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      const ProfileScreen(),
      const CategoryScreen(),
      const ProductListScreen(),
      const HomeScreen(),
    ];
  }
}
