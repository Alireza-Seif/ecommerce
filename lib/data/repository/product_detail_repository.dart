import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/product_detail_datasource.dart';
import 'package:ecommerce/data/model/product_image_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IProductDetailRepository {
  Future<Either<String,List<ProductImageModel>>> getProductDetailImage();
}

class ProductDetailRepository extends IProductDetailRepository {

  @override
  Future<Either<String, List<ProductImageModel>>> getProductDetailImage() async {
  final IProductDetailDatasource _datasource = locator.get();

    try {
      final result = await _datasource.getGallery();
      return Right(result);
    } on ApiException catch(ex) {
      return Left(ex.message ?? 'unknown error');
    }
  }
}