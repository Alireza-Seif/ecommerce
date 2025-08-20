import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/category_product_datasource.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<ProductModel>>> getProductsByCategoryId(
      String categoryId);
}

class CategoryProductRepository extends ICategoryProductRepository {
  final ICategoryProductDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<ProductModel>>> getProductsByCategoryId(
      String categoryId) async {
        try{
          var response = await _dataSource.getProductsByCategoryId(categoryId);
          return right(response);
        } on ApiException catch (ex){
          return left(ex.message ?? 'unknown error');
        }
      }
}
