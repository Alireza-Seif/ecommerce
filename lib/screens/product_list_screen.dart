import 'package:ecommerce/bloc/categoryProduct/category_product_bloc.dart';
import 'package:ecommerce/bloc/categoryProduct/category_product_event.dart';
import 'package:ecommerce/bloc/categoryProduct/category_product_state.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/widgets/loading_animation.dart';
import 'package:ecommerce/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  CategoryModel category;
  ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInitializeEvent(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
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
                              Expanded(
                                child: Text(
                                  widget.category.title ?? 'محصول',
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
                  if (state is CategoryProductLoadingState) ...{
                    SliverToBoxAdapter(
                      child: LoadingAnimation(),
                    ),
                  },
                  if (state is CategoryProductResponseSuccessState) ...{
                    state.productListByCategory.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (productList) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            childCount: productList.length,
                            (context, index) {
                              // return  ProductItem();
                              return ProductItem(productList[index]);
                            },
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 2.5,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 30),
                        ),
                      );
                    })
                  }
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
