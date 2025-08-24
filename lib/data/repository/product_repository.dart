import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/product_datasource.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getHottest();
  Future<Either<String, List<Product>>> getBestSeller();
}

class ProductRepository extends IProductRepository {
  final IProductDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _dataSource.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
  
  @override
  Future<Either<String, List<Product>>> getBestSeller() async{
   try {
      var response = await _dataSource.getBeastSeller ();
      return right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
  
  @override
  Future<Either<String, List<Product>>> getHottest() async{
    try {
      var response = await _dataSource.getHottest();
      return right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
