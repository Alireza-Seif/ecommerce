import 'package:ecommerce/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 32),
            child: Container(
              height: 46,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_apple_blue.png'),
                    const Expanded(
                      child: Text(
                        'حساب کاربری',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                          color: CustomColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Text(
            'علیرضاسیف',
            style: TextStyle(fontFamily: 'SB', fontSize: 16),
          ),
          const Text(
            '09120379809',
            style: TextStyle(fontFamily: 'SM', fontSize: 12),
          ),
          const SizedBox(height: 30),
          const Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              children: [
                // CategoryItemChip(),
                // CategoryItemChip(),
                // CategoryItemChip(),
                // CategoryItemChip(),
                // CategoryItemChip(),
                // CategoryItemChip(),
                // CategoryItemChip(),
                // CategoryItemChip(),
                // CategoryItemChip(),
              ],
            ),
          ),
          const Spacer(),
          const Text(
            'اپل شاپ',
            style: TextStyle(
                fontFamily: 'SM', fontSize: 10, color: CustomColors.grey),
          ),
          const Text(
            'v-1.0.00',
            style: TextStyle(
                fontFamily: 'SM', fontSize: 10, color: CustomColors.grey),
          ),
          const Text(
            'Instaagraam.comm/Mojava-dev',
            style: TextStyle(
                fontFamily: 'SM', fontSize: 10, color: CustomColors.grey),
          ),
        ],
      )),
    );
  }
}
