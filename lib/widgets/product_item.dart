import 'package:ecommerce/bloc/product/product_bloc.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:ecommerce/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  Product productItem;
  ProductItem(
    this.productItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ProductBloc(),
              child: ProductDetailScreen(productItem),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Expanded(child: Container()),
                SizedBox(
                  height: 98,
                  width: 98,
                  child: Center(
                    child: CachedImage(imageUrl: productItem.thumbnail),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset(
                      'assets/images/active_fav_product.png',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          15,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      child: Text(
                        '${productItem.percent!.round()} %',
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
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                    right: 10,
                  ),
                  child: Text(
                    productItem.name,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 53,
              decoration: const BoxDecoration(
                color: CustomColors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.blue,
                    blurRadius: 25,
                    spreadRadius: -12,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 24,
                      child: Image.asset(
                          'assets/images/icon_right_arrow_circle.png'),
                    ),
                    const Spacer(),
                    const Text('تومان',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 14,
                          color: Colors.white,
                        )),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productItem.price.toString(),
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          productItem.realPrice.toString(),
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
