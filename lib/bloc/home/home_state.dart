import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/banner_model.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/data/model/product_model.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}


class HomeInitState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerModel>> bannerList;
  Either<String, List<CategoryModel>> categoryList;
  Either<String, List<ProductModel>> productList;



  HomeRequestSuccessState(this.bannerList, this.categoryList,this.productList);
}
