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
    Either<String, List<ProductModel>> hottestProductList;
      Either<String, List<ProductModel>> bestSellerProductList;



  HomeRequestSuccessState(this.bannerList, this.categoryList, this.productList,
      this.hottestProductList, this.bestSellerProductList);
}

// class HomeRequestHottestSuccessState extends HomeState {
//   Either<String, List<ProductModel>> hottestProductList;

//   HomeRequestHottestSuccessState(this.hottestProductList);
// }


// class HomeRequestBestSellerSuccessState extends HomeState {
//   Either<String, List<ProductModel>> bestSellerProductList;

//   HomeRequestBestSellerSuccessState(this.bestSellerProductList);
// }