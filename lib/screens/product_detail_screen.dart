import 'dart:ui';

import 'package:ecommerce/bloc/basket/basket_bloc.dart';
import 'package:ecommerce/bloc/basket/basket_event.dart';
import 'package:ecommerce/bloc/comment/comment_bloc.dart';
import 'package:ecommerce/bloc/comment/comment_event.dart';
import 'package:ecommerce/bloc/comment/comment_state.dart';
import 'package:ecommerce/bloc/product/product_bloc.dart';
import 'package:ecommerce/bloc/product/product_event.dart';
import 'package:ecommerce/bloc/product/product_state.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/product_image_model.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/data/model/product_property_model.dart';
import 'package:ecommerce/data/model/product_variant.dart';
import 'package:ecommerce/data/model/variant.dart';
import 'package:ecommerce/data/model/variant_type_model.dart';
import 'package:ecommerce/di/di.dart';

import 'package:ecommerce/widgets/cached_image.dart';
import 'package:ecommerce/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  Product product;
  ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) {
        var bloc = ProductBloc();
        bloc.add(ProductInitializedEvent(
            widget.product.id, widget.product.categoryId));
        return bloc;
      }),
      child: DetailScreenContent(parentWidget: widget),
    );
  }
}

class DetailScreenContent extends StatelessWidget {
  const DetailScreenContent({
    super.key,
    required this.parentWidget,
  });

  final ProductDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductDetailLoadingState) {
            return Center(
              child: LoadingAnimation(),
            );
          }
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailResponseState) ...{
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
                                child: state.productCategory.fold(
                                  (l) {
                                    return Text(
                                      l,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'SB',
                                        fontSize: 16,
                                        color: CustomColors.blue,
                                      ),
                                    );
                                  },
                                  (productCategory) {
                                    return Text(
                                      productCategory.title!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'SB',
                                        fontSize: 16,
                                        color: CustomColors.blue,
                                      ),
                                    );
                                  },
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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        parentWidget.product.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                },
                if (state is ProductDetailResponseState) ...{
                  state.productImages.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (productImageList) {
                    return GalleryWidget(
                        parentWidget.product.thumbnail, productImageList);
                  })
                },
                if (state is ProductDetailResponseState) ...{
                  state.productVariant.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (productVariantList) {
                    return VariantContainerGenerator(productVariantList);
                  })
                },
                if (state is ProductDetailResponseState) ...{
                  state.productProperties.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (propertyList) {
                    return ProductProperties(propertyList);
                  }),
                  ProductDescription(parentWidget.product.description),
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) {
                                final bloc = CommentBloc(locator.get());
                                bloc.add(CommentInitializeEvent(
                                    parentWidget.product.id));
                                return bloc;
                              },
                              child: DraggableScrollableSheet(
                                initialChildSize: 0.5,
                                minChildSize: 0.2,
                                maxChildSize: 0.7,
                                builder: (context, scrollController) =>
                                    CommentBottomSheet(scrollController),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 46,
                        margin:
                            const EdgeInsets.only(top: 24, left: 44, right: 44),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: CustomColors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/images/icon_left_category.png'),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
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
                  ),
                },
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PriceTagButton(),
                        AddToBasketButton(parentWidget.product),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet(
    this.controller, {
    super.key,
  });

  ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoading) {
          return LoadingAnimation();
        }

        return CustomScrollView(
          controller: controller,
          slivers: [
            if (state is CommentResponse) ...{
              state.response.fold(
                (l) {
                  return SliverToBoxAdapter(
                      child: Center(
                          child: Column(
                    children: [
                      LoadingAnimation(loadingColor: CustomColors.red),
                      SizedBox(height: 10),
                      Text('خطایی در نمایش نظرات به وجود آمده',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  )));
                },
                (commentList) {
                  if (commentList.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                          child: Text('نظری برای این محصول ثبت نشده است')),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: commentList.length,
                      (context, index) {
                        return Container(
                          padding: EdgeInsetsGeometry.all(16),
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      (commentList[index].userName.isEmpty)
                                          ? 'کاربر'
                                          : commentList[index].userName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      commentList[index].text,
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: (commentList[index].avatar.isNotEmpty)
                                      ? CachedImage(
                                          imageUrl: commentList[index]
                                              .userThumbnailUrl)
                                      : Image.asset(
                                          'assets/images/avatar.png')),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            },
          ],
        );
      },
    );
  }
}

class ProductProperties extends StatefulWidget {
  List<Property> productPropertyList;
  ProductProperties(
    this.productPropertyList, {
    super.key,
  });

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
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
              child: GestureDetector(
                onTap: () => setState(() {
                  _isVisible = !_isVisible;
                }),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_category.png'),
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
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustomColors.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.productPropertyList.length,
                itemBuilder: (context, index) {
                  var property = widget.productPropertyList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          '${property.value!} : ${property.title!}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'SM',
                              fontSize: 14,
                              height: 1.8,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  String productDescription;
  ProductDescription(
    this.productDescription, {
    super.key,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
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
              child: GestureDetector(
                onTap: () => setState(() => _isVisible = !_isVisible),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_category.png'),
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
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: CustomColors.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  widget.productDescription,
                  style: TextStyle(fontFamily: 'SM', fontSize: 16, height: 1.8),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  List<ProductImageModel> productImageList;
  String? defaultProductThumbnail;
  int selectedItem = 0;

  GalleryWidget(
    this.defaultProductThumbnail,
    this.productImageList, {
    super.key,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/icon_star.png'),
                          SizedBox(width: 2),
                          const Text(
                            '4.6',
                            style: TextStyle(fontFamily: 'SM', fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                          height: double.infinity,
                          child: CachedImage(
                            imageUrl: widget.productImageList.isEmpty
                                ? widget.defaultProductThumbnail!
                                : widget.productImageList[widget.selectedItem]
                                    .imageUrl!,
                            radius: 10,
                          )),
                      const Spacer(),
                      Image.asset('assets/images/icon_favorite_deactivate.png'),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: ListView.builder(
                    itemCount: widget.productImageList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedItem = index;
                          });
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.only(left: 20),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, color: CustomColors.grey),
                          ),
                          child: CachedImage(
                            imageUrl: widget.productImageList[index].imageUrl!,
                            radius: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              }
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  Product product;
  AddToBasketButton(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductBloc>().add(ProductAddToBasket(product));
        context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
      },
      child: Stack(
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
      ),
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

class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;
  ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String categoryColor = 'ff${widget.variantList[index].value}';
            int hexColor = int.parse(categoryColor, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 8),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(hexColor),
                  border: selectedIndex == index
                      ? Border.all(
                          width: 3,
                          color: Color(hexColor),
                          strokeAlign: BorderSide.strokeAlignOutside)
                      : null,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(hexColor),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VoltageVariantList extends StatefulWidget {
  List<Variant> voltageVariantList;
  VoltageVariantList(this.voltageVariantList, {super.key});

  @override
  State<VoltageVariantList> createState() => _VoltageVariantListState();
}

class _VoltageVariantListState extends State<VoltageVariantList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.voltageVariantList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => setState(() {
                selectedIndex = index;
              }),
              child: Container(
                height: 25,
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: selectedIndex == index
                        ? Border.all(
                            width: 1,
                            color: CustomColors.blueIndicator,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          )
                        : Border.all(width: 1, color: CustomColors.grey)),
                child: Center(
                  child: Text(
                    widget.voltageVariantList[index].value!,
                    style: TextStyle(fontFamily: 'SB', fontSize: 12),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariants;
  StorageVariantList(this.storageVariants, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageVariants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => setState(() {
                selectedIndex = index;
              }),
              child: Container(
                height: 25,
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: selectedIndex == index
                        ? Border.all(
                            width: 2, color: CustomColors.blueIndicator)
                        : Border.all(width: 1, color: CustomColors.grey)),
                child: Center(
                  child: Text(
                    widget.storageVariants[index].value!,
                    style: TextStyle(fontFamily: 'SB', fontSize: 12),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  List<ProductVariant> productVariantList;
  VariantContainerGenerator(this.productVariantList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant)
            }
          }
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  ProductVariant productVariant;
  VariantGeneratorChild(this.productVariant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 44, right: 44, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title!,
            style: TextStyle(fontFamily: 'SM', fontSize: 12),
          ),
          const SizedBox(height: 10),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(productVariant.variantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantList(productVariant.variantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.VOLTAGE) ...{
            VoltageVariantList(productVariant.variantList)
          },
        ],
      ),
    );
  }
}
