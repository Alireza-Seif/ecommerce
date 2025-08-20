import 'package:ecommerce/bloc/categoryProduct/category_product_bloc.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/screens/product_list_screen.dart';
import 'package:ecommerce/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryIconItemChip extends StatelessWidget {
  final CategoryModel category;
  const CategoryIconItemChip(
    this.category, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int categoryColor = int.parse('0xff${category.color!}');
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CategoryProductBloc(),
              child: ProductListScreen(category),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: Color(categoryColor),
                  shadows: [
                    BoxShadow(
                        color: Color(categoryColor),
                        blurRadius: 20,
                        spreadRadius: -10,
                        offset: Offset(0, 10))
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: CachedImage(
                    imageUrl: category.icon!,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            category.title ?? 'محصول',
            style: TextStyle(fontFamily: 'SB', fontSize: 12),
          )
        ],
      ),
    );
  }
}
