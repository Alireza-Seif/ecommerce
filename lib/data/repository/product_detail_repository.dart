import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/product_detail_datasource.dart';
import 'package:ecommerce/data/model/product_image_model.dart';
import 'package:ecommerce/data/model/product_variant.dart';
import 'package:ecommerce/data/model/variant.dart';
import 'package:ecommerce/data/model/variant_type_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImageModel>>> getProductDetailImage();
  Future<Either<String, List<VariantType>>> getVariantTypes();
  Future<Either<String, List<Variant>>> getVariants();
  Future<Either<String, List<ProductVariant>>> getProductVariants();
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImageModel>>>
      getProductDetailImage() async {
    try {
      final result = await _datasource.getGallery();
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
  Future<Either<String, List<Variant>>> getVariants() async {
    try {
      final result = await _datasource.getVariant();
      return right(result);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants() async {
    try {
      final response = await _datasource.getProductVariants();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error');
    }
  }
}
