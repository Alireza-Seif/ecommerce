import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/data/model/product_image_model.dart';
import 'package:ecommerce/data/model/product_variant.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImageModel>> productImages;
  Either<String, List<ProductVariant>> productVariant;
  Either<String, CategoryModel> productCategory;

  ProductDetailResponseState(
      this.productImages, this.productVariant, this.productCategory);
}
