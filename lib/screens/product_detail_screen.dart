import 'dart:ui';

import 'package:ecommerce/constants/colors.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 32),
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
                              'آیفون',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16,
                                color: CustomColors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Image.asset('assets/images/icon_back.png'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Se آیفون 2022',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'SB', fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Container(
                    height: 284,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 15, right: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/icon_star.png'),
                                const Text(
                                  '4.6',
                                  style:
                                      TextStyle(fontFamily: 'SM', fontSize: 12),
                                ),
                                const Spacer(),
                                SizedBox(
                                    height: double.infinity,
                                    child: Image.asset(
                                        'assets/images/iphone.png')),
                                const Spacer(),
                                Image.asset(
                                    'assets/images/icon_favorite_deactive.png'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 44),
                          child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: CustomColors.grey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child:
                                      Image.asset('assets/images/iphone.png'),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 44, left: 44),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'انتخاب رنگ',
                        style: TextStyle(fontFamily: 'SM', fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 26,
                            width: 26,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          Container(
                            height: 26,
                            width: 26,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          Container(
                            height: 26,
                            width: 26,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 44, left: 44),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'انتخاب حافظه داخلی',
                        style: TextStyle(fontFamily: 'SM', fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                    width: 1, color: CustomColors.grey)),
                            child: const Center(
                              child: Text(
                                '128',
                                style:
                                    TextStyle(fontFamily: 'SB', fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                    width: 1, color: CustomColors.grey)),
                            child: const Center(
                              child: Text(
                                '128',
                                style:
                                    TextStyle(fontFamily: 'SB', fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            height: 25,
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                    width: 1, color: CustomColors.grey)),
                            child: const Center(
                              child: Text(
                                '128',
                                style:
                                    TextStyle(fontFamily: 'SB', fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 46,
                  margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: CustomColors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/images/icon_left_categroy.png'),
                        const SizedBox(width: 10),
                        const Text(
                          'مشاهده',
                          style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: CustomColors.blue),
                        ),
                        const Spacer(),
                        const Text(
                          ': مشخصات فنی',
                          style: TextStyle(fontFamily: 'SM'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 46,
                  margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: CustomColors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/images/icon_left_categroy.png'),
                        const SizedBox(width: 10),
                        const Text(
                          'مشاهده',
                          style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: CustomColors.blue),
                        ),
                        const Spacer(),
                        const Text(
                          ': توضیحات محصول',
                          style: TextStyle(fontFamily: 'SM'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 46,
                  margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: CustomColors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/images/icon_left_categroy.png'),
                        const SizedBox(width: 10),
                        const Text(
                          'مشاهده',
                          style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: CustomColors.blue),
                        ),
                        const Spacer(),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 26,
                              width: 26,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 15,
                              child: Container(
                                height: 26,
                                width: 26,
                                margin: const EdgeInsets.only(left: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 30,
                              child: Container(
                                height: 26,
                                width: 26,
                                margin: const EdgeInsets.only(left: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 45,
                              child: Container(
                                height: 26,
                                width: 26,
                                margin: const EdgeInsets.only(left: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 60,
                              child: Container(
                                height: 26,
                                width: 26,
                                margin: const EdgeInsets.only(left: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '+10',
                                    style: TextStyle(
                                        fontFamily: 'SB',
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          ': نظرات کاربران',
                          style: TextStyle(fontFamily: 'SM'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PriceTagButton(),
                      AddToBaasketButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBaasketButton extends StatelessWidget {
  const AddToBaasketButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const SizedBox(
              height: 53,
              width: 160,
              child: Center(
                child: Text(
                  'افزودن سبد خرید',
                  style: TextStyle(
                      fontFamily: 'SB', fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              height: 53,
              width: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text('تومان',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12,
                          color: Colors.white,
                        )),
                    const SizedBox(width: 5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '49.800.000',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '47.800.000',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            15,
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                        child: Text(
                          '%4',
                          style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
