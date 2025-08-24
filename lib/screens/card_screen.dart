import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce/bloc/basket/basket_bloc.dart';
import 'package:ecommerce/bloc/basket/basket_state.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/basket_item.dart';
import 'package:ecommerce/util/extensions/string_extensions.dart';
import 'package:ecommerce/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<BasketItem>('basketItemBox');
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
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
                                Image.asset(
                                    'assets/images/icon_apple_blue.png'),
                                const Expanded(
                                  child: Text(
                                    'سبد خرید',
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
                    ),
                    if (state is BasketDataFetchedState) ...{
                      state.basketItemList.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Text(l),
                          );
                        },
                        (basketItemList) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return CardItem(basketItemList[index]);
                              },
                              childCount: basketItemList.length,
                            ),
                          );
                        },
                      ),
                    },
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 60),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 44, vertical: 10),
                  child: SizedBox(
                    height: 53,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'ادامه خرید',
                        style: TextStyle(fontSize: 18, fontFamily: 'SM'),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  BasketItem basketItem;
  CardItem(this.basketItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    height: 104,
                    width: 75,
                    child: Center(
                      child: CachedImage(
                        imageUrl: basketItem.thumbnail,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          basketItem.name,
                          style: TextStyle(fontFamily: 'SB', fontSize: 16),
                        ),
                        SizedBox(height: 6),
                        const Text(
                          'گارانتی',
                          style: TextStyle(fontFamily: 'SM', fontSize: 12),
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              basketItem.realPrice.toString(),
                              style: TextStyle(fontFamily: 'SM', fontSize: 12),
                            ),
                            SizedBox(width: 4),
                            const Text(
                              'تومان',
                              style: TextStyle(fontFamily: 'SM', fontSize: 12),
                            ),
                            SizedBox(width: 4),
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
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
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          children: [
                            OptionCheap(
                              'آبی',
                              color: '4287f5',
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CustomColors.red, width: 1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text(
                                        'حذف',
                                        style: TextStyle(
                                            fontFamily: 'SM',
                                            fontSize: 12,
                                            color: CustomColors.red),
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Image.asset(
                                      'assets/images/icon_trash.png',
                                      color: CustomColors.red,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 3.0,
              dashLength: 8.0,
              dashColor: CustomColors.grey.withOpacity(0.5),
              dashGapLength: 3.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  basketItem.price.toString(),
                  style: TextStyle(fontFamily: 'SB', fontSize: 16),
                ),
                SizedBox(width: 5),
                Text(
                  'تومن',
                  style: TextStyle(fontFamily: 'SB', fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  String? color;
  String title;
  OptionCheap(
    this.title, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.grey, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(fontFamily: 'SM', fontSize: 12),
              ),
            ),
            if (color != null && color!.isNotEmpty) ...{
              Container(
                height: 12,
                width: 12,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color.toColor()),
              )
            },
          ],
        ),
      ),
    );
  }
}
