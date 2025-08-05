import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/product_image_model.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
Either<String, List<ProductImageModel>> getProductImages;
ProductDetailResponseState(this.getProductImages);
}