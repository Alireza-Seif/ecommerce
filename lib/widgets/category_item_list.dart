import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class CategoryItemChip extends StatelessWidget {
  final CategoryModel category;
  const CategoryItemChip(
    this.category, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int categoryColor = int.parse('0xff${category.color!}');
    return Column(
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
              width: 24,height: 24,
              child: CachedImage(imageUrl: category.icon!,)),
          ],
        ),
        const SizedBox(height: 10),
         Text(
          category.title ?? 'محصول',
          style: TextStyle(fontFamily: 'SB', fontSize: 12),
        )
      ],
    );
  }
}
