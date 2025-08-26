import 'package:ecommerce/bloc/home/home_bloc.dart';
import 'package:ecommerce/bloc/home/home_event.dart';
import 'package:ecommerce/bloc/home/home_state.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/banner_model.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/widgets/banner_slider.dart';
import 'package:ecommerce/widgets/category_icon_item_list.dart';
import 'package:ecommerce/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitializeEvent());
    // BlocProvider.of<HomeBloc>(context).add(HomeGetBestSellerEvent());
    // BlocProvider.of<HomeBloc>(context).add(Home());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(slivers: [
              if (state is HomeLoadingState) ...{
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: CustomColors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              } else ...{
                _getSearchBox(),
                if (state is HomeRequestSuccessState) ...[
                  state.bannerList.fold(
                    (exceptionMessages) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessages),
                      );
                    },
                    (listBanner) {
                      return _getBanners(listBanner);
                    },
                  )
                ],
                _getCategoryListTitle(),
                if (state is HomeRequestSuccessState) ...[
                  state.categoryList.fold(
                    (exceptionMessages) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessages),
                      );
                    },
                    (categoryList) {
                      return _getCategoryList(categoryList);
                    },
                  )
                ],
                _getBestSellerTitle(),
                if (state is HomeRequestSuccessState) ...[
                  state.bestSellerProductList.fold(
                    (exceptionMessages) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessages),
                      );
                    },
                    (productList) {
                      return _getBestSellerProducts(productList);
                    },
                  )
                ],
                _getMostViewedTitle(),
                if (state is HomeRequestSuccessState) ...[
                  state.hottestProductList.fold(
                    (exceptionMessages) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessages),
                      );
                    },
                    (productList) {
                      return _getMostViewedProduct(productList);
                    },
                  )
                ],
              },
            ]);
          },
        ),
      ),
    );
  }
}

class _getMostViewedProduct extends StatelessWidget {
  final List<Product> productList;
  const _getMostViewedProduct(
    this.productList);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: ProductItem(productList[index]),
                );
              })),
        ),
      ),
    );
  }
}

class _getMostViewedTitle extends StatelessWidget {
  const _getMostViewedTitle();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 32),
        child: Row(
          children: [
            const Text(
              'پر بازدید ترین ها',
              style: TextStyle(
                  fontFamily: 'SB', fontSize: 12, color: CustomColors.grey),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(fontFamily: 'SB', color: CustomColors.blue),
            ),
            const SizedBox(width: 10),
            Image.asset('assets/images/icon_left_category.png'),
          ],
        ),
      ),
    );
  }
}

class _getBestSellerProducts extends StatelessWidget {
  final List<Product> productList;
  const _getBestSellerProducts(
    this.productList);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: ProductItem(productList[index]),
                );
              })),
        ),
      ),
    );
  }
}

class _getBestSellerTitle extends StatelessWidget {
  const _getBestSellerTitle();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          children: [
            const Text(
              'پرفروش ترین ها',
              style: TextStyle(
                  fontFamily: 'SB', fontSize: 12, color: CustomColors.grey),
            ),
            const Spacer(),
            const Text(
              'مشاهده همه',
              style: TextStyle(fontFamily: 'SB', color: CustomColors.blue),
            ),
            const SizedBox(width: 10),
            Image.asset('assets/images/icon_left_category.png'),
          ],
        ),
      ),
    );
  }
}

class _getCategoryList extends StatelessWidget {
  final List<CategoryModel> categoryList;
  const _getCategoryList(
    this.categoryList);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.only(right: 20),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 20),
              child: CategoryIconItemChip(categoryList[index]),
            );
          },
        ),
      ),
    ));
  }
}

class _getCategoryListTitle extends StatelessWidget {
  const _getCategoryListTitle();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 20, bottom: 20, top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'دسته بندی',
              style: TextStyle(
                  fontFamily: 'SB', fontSize: 12, color: CustomColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _getBanners extends StatelessWidget {
  List<BannerModel> banners;
  _getBanners(
    this.banners);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(
        bannerList: banners,
      ),
    );
  }
}

class _getSearchBox extends StatelessWidget {
  const _getSearchBox();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
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
                Image.asset('assets/images/icon_search.png'),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    'جستجوی محصولات',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 16,
                      color: CustomColors.grey,
                    ),
                  ),
                ),
                Image.asset('assets/images/icon_apple_blue.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
