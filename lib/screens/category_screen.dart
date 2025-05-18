import 'package:ecommerce/bloc/category/category_bloc.dart';
import 'package:ecommerce/bloc/category/category_event.dart';
import 'package:ecommerce/bloc/category/category_state.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel>? list;

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestEvent());
    super.initState();
  }

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
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
              if (state is CategoryLoadingState) {
                return SliverToBoxAdapter(child: CircularProgressIndicator(color: CustomColors.blue));
              } else if (state is CategoryResponseState) {
               return  state.response.fold(
                  (l) {
                    return SliverToBoxAdapter(child: Center(child: Text(l)));
                  },
                  (r) {
                    return   _categoryList(list: r);
                  },
                );
              }
              return SliverToBoxAdapter(child: Center(child: Text('Error')));
            }),
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
