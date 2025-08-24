import 'dart:ui';

import 'package:ecommerce/bloc/basket/basket_bloc.dart';
import 'package:ecommerce/bloc/basket/basket_event.dart';
import 'package:ecommerce/bloc/category/category_bloc.dart';
import 'package:ecommerce/bloc/home/home_bloc.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/basket_item.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/screens/card_screen.dart' hide CardItem;
import 'package:ecommerce/screens/category_screen.dart';
import 'package:ecommerce/screens/hom_screen.dart';
import 'package:ecommerce/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('basketItemBox');
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
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
                            Image.asset('assets/images/icon_home_active.png')),
                    label: 'خانه',
                    icon: Image.asset('assets/images/icon_home.png'),
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
                        child: Image.asset(
                            'assets/images/icon_basket_active.png')),
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
                            'assets/images/icon_profile_active.png')),
                    label: 'حساب کاربری',
                    icon: Image.asset('assets/images/icon_profile.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      BlocProvider(
        create: (context) => HomeBloc(),
        child: HomeScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: CategoryScreen(),
      ),
      BlocProvider(
        create: (context) {
          var bloc = BasketBloc();
          bloc.add(BasketFetchFromHiveEvent());
          return bloc;
        },
        child: CardScreen(),
      ),
      const ProfileScreen(),
    ];
  }
}
