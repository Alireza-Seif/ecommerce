import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/product_model.dart';

abstract class CategoryProductState {}

class CategoryProductLoadingState extends CategoryProductState {}

class CategoryProductResponseSuccessState extends CategoryProductState {
  Either<String, List<Product>> productListByCategory;
  CategoryProductResponseSuccessState(this.productListByCategory);
}
