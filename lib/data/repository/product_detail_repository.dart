import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/product_detail_datasource.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/data/model/product_image_model.dart';
import 'package:ecommerce/data/model/product_variant.dart';
import 'package:ecommerce/data/model/product_property_model.dart';
import 'package:ecommerce/data/model/variant.dart';
import 'package:ecommerce/data/model/variant_type_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImageModel>>> getProductDetailImage(
      String productId);
  Future<Either<String, List<VariantType>>> getVariantTypes();
  // Future<Either<String, List<Variant>>> getVariants(productId);
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);
  Future<Either<String, CategoryModel>> getProductCategory(String categoryId);
  Future<Either<String, List<Property>>> getProductProperties(String productId);
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImageModel>>> getProductDetailImage(
      String productId) async {
    try {
      final result = await _datasource.getGallery(productId);
      return right(result);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      final result = await _datasource.getVariantTypes();
      return right(result);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }

  @override
  Future<Either<String, List<Variant>>> getVariants(String productId) async {
    try {
      final result = await _datasource.getVariant(productId);
      return right(result);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      final response = await _datasource.getProductVariants(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }

  @override
  Future<Either<String, CategoryModel>> getProductCategory(
      String categoryId) async {
    try {
      final response = await _datasource.getProductCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }

  @override
  Future<Either<String, List<Property>>> getProductProperties(
      String productId) async {
    try {
      final response = await _datasource.getProductProperties(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }
}
