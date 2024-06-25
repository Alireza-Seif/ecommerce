import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/widgets/banner_slider.dart';
import 'package:ecommerce/widgets/category_item_list.dart';
import 'package:ecommerce/widgets/product_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child:  BannerSlider(),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'دسته بندی',
                      style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 12,
                          color: CustomColors.gery),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: CategoryHorizontaltemList(),
                    );
                  },
                ),
              ),
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده همه',
                      style: TextStyle(
                          fontFamily: 'SB', color: CustomColors.blue),
                    ),
                    const Spacer(),
                    const Text(
                      'پرفروش ترین ها',
                      style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 12,
                          color: CustomColors.gery),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: ProductItem(),
                        );
                      })),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 32),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده همه',
                      style: TextStyle(
                          fontFamily: 'SB', color: CustomColors.blue),
                    ),
                    const Spacer(),
                    const Text(
                      'پر بازدید ترین ها',
                      style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 12,
                          color: CustomColors.gery),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: ProductItem(),
                        );
                      })),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
