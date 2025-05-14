import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/category_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';
 
abstract class ICategoryDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDatasource extends ICategoryDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await _dio.get('collections/category/records');
      return (response.data['items'] as List)
          .map<CategoryModel>(
              (jsonObject) => CategoryModel.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode ?? 0,
        ex.response?.data?['message'] ?? 'Unknown error occurred',
      );
    } catch (ex) {
      throw ApiException(0, 'Unknown error occurred');
    }
  }
}
