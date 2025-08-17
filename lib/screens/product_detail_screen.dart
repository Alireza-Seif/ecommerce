import 'dart:ui';

import 'package:ecommerce/bloc/product/product_bloc.dart';
import 'package:ecommerce/bloc/product/product_event.dart';
import 'package:ecommerce/bloc/product/product_state.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/product_image_model.dart';
import 'package:ecommerce/data/model/product_variant.dart';
import 'package:ecommerce/data/model/variant.dart';
import 'package:ecommerce/data/model/variant_type_model.dart';
import 'package:ecommerce/data/repository/product_detail_repository.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(ProductInitializedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailLoadingState) ...{
                  SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator()),
                    ),
                  )
                },
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
                if (state is ProductDetailResponseState) ...{
                  state.productImages.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (productImageList) {
                    return GalleryWidget(productImageList);
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

                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding:
                //         const EdgeInsets.only(top: 20, right: 44, left: 44),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         const Text(
                //           'انتخاب حافظه داخلی',
                //           style: TextStyle(fontFamily: 'SM', fontSize: 12),
                //         ),
                //         const SizedBox(height: 10),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Container(
                //               height: 25,
                //               margin: const EdgeInsets.only(left: 10),
                //               padding:
                //                   const EdgeInsets.symmetric(horizontal: 20),
                //               decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: const BorderRadius.all(
                //                     Radius.circular(8),
                //                   ),
                //                   border: Border.all(
                //                       width: 1, color: CustomColors.grey)),
                //               child: const Center(
                //                 child: Text(
                //                   '128',
                //                   style:
                //                       TextStyle(fontFamily: 'SB', fontSize: 12),
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               height: 25,
                //               margin: const EdgeInsets.only(left: 10),
                //               padding:
                //                   const EdgeInsets.symmetric(horizontal: 20),
                //               decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: const BorderRadius.all(
                //                     Radius.circular(8),
                //                   ),
                //                   border: Border.all(
                //                       width: 1, color: CustomColors.grey)),
                //               child: const Center(
                //                 child: Text(
                //                   '128',
                //                   style:
                //                       TextStyle(fontFamily: 'SB', fontSize: 12),
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               height: 25,
                //               margin: const EdgeInsets.only(left: 10),
                //               padding:
                //                   const EdgeInsets.symmetric(horizontal: 20),
                //               decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: const BorderRadius.all(
                //                     Radius.circular(8),
                //                   ),
                //                   border: Border.all(
                //                       width: 1, color: CustomColors.grey)),
                //               child: const Center(
                //                 child: Text(
                //                   '128',
                //                   style:
                //                       TextStyle(fontFamily: 'SB', fontSize: 12),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
                        AddToBasketButton(),
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

class GalleryWidget extends StatefulWidget {
  List<ProductImageModel> productImageList;
  int selectedItem = 0;
  GalleryWidget(
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
                            imageUrl: widget
                                .productImageList[widget.selectedItem]
                                .imageUrl!,
                            radius: 10,
                          )),
                      const Spacer(),
                      Image.asset('assets/images/icon_favorite_deactivate.png'),
                    ],
                  ),
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({super.key});

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

class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;
  ColorVariantList(this.variantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  List<Widget> colorWidget = [];

  @override
  void initState() {
    for (var colorVariant in widget.variantList) {
      String categoryColor = 'ff${colorVariant.value}';
      int hexColor = int.parse(categoryColor, radix: 16);
      var item = Container(
        margin: EdgeInsets.only(left: 8),
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          color: Color(hexColor),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      );
      colorWidget.add(item);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colorWidget.length,
          itemBuilder: (context, index) {
            return colorWidget[index];
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
  List<Widget> voltageWidgetList = [];
  @override
  void initState() {
    for (var voltageVariant in widget.voltageVariantList) {
      var item = Container(
        height: 25,
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(width: 1, color: CustomColors.grey)),
        child: Center(
          child: Text(
            voltageVariant.value!,
            style: TextStyle(fontFamily: 'SB', fontSize: 12),
          ),
        ),
      );
      voltageWidgetList.add(item);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: voltageWidgetList.length,
          itemBuilder: (context, index) {
            return voltageWidgetList[index];
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
  List<Widget> storageWidgetList = [];
  @override
  void initState() {
    for (var storageVariant in widget.storageVariants) {
      var item = Container(
        height: 25,
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(width: 1, color: CustomColors.grey)),
        child: Center(
          child: Text(
            storageVariant.value!,
            style: TextStyle(fontFamily: 'SB', fontSize: 12),
          ),
        ),
      );
      storageWidgetList.add(item);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: storageWidgetList.length,
          itemBuilder: (context, index) {
            return storageWidgetList[index];
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
