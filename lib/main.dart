import 'dart:ui';

import 'package:ecommerce/bloc/auth/auth_bloc.dart';
import 'package:ecommerce/bloc/product/home_bloc.dart';
// import 'package:ecommerce/bloc/home_event.dart';
// import 'package:ecommerce/bloc/home_state.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/repository/authentication_repository.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/screens/card_screen.dart';
import 'package:ecommerce/screens/hom_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/product_list_screen.dart';
import 'package:ecommerce/screens/profile_screen.dart';
import 'package:ecommerce/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
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
      home: Scaffold(
        body: BlocProvider(
          create: (context) => AuthBloc(),
          child: LoginScreen(),
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
      const CardScreen(),
      const ProductListScreen(),
      const HomeScreen(),
    ];
  }
}

// class MyScreen extends StatelessWidget {
//   const MyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               BlocProvider.of<HomeBloc>(context).add(ClickEvent());
//             },
//             child: const Text(
//               ('clicked'),
//             ),
//           ),
//           BlocBuilder<HomeBloc, HomeState>(
//             builder: ((context, state) {
//               if (state is InitHome) {
//                 return const Text('0');
//               } else if (state is UpdateHome) {
//                 print('doing the job!');
//                 return Text('${state.x}');
//               } else {
//                 return const Text('error');
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
