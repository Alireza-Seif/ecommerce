import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/data/repository/category_repository.dart';
import 'package:ecommerce/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel>? list;
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
                            'دسته بندی',
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
            SliverToBoxAdapter(
              child: ElevatedButton(
                  onPressed: () async {
                    var repository = CategoryRepository();
                    var either = await repository.getCategories();
                    either.fold(
                      (l) => Text(l),
                      (r) {
                        setState(() {
                          list = r;
                        });
                      },
                    );
                  },
                  child: Text('get data')),
            ),
            _categoryList(list: list)
          ],
        ),
      ),
    );
  }
}

class _categoryList extends StatelessWidget {
  List<CategoryModel>? list;

  _categoryList({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CachedImage(
              imageUrl: list?[index].thumbnail ?? 'test',
            );
          },
          childCount: list?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
      ),
    );
  }
}
