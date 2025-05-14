import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/category_datasource.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<CategoryModel>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _datasource = locator.get();
  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
