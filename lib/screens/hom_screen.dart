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
                            'جستجوی محصولات',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: CustomColors.gery,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset('assets/images/icon_search.png'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: BannerSlider(),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(right: 20, bottom: 20, top: 32),
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
                      child: CategoryltemChip(),
                    );
                  },
                ),
              ),
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده همه',
                      style:
                          TextStyle(fontFamily: 'SB', color: CustomColors.blue),
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
                      style:
                          TextStyle(fontFamily: 'SB', color: CustomColors.blue),
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
