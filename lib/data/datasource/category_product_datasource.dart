import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class ICategoryProductDataSource {
  Future<List<ProductModel>> getProductsByCategoryId(String categoryId);
}

class CategoryProductRemoteDatasource extends ICategoryProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductModel>> getProductsByCategoryId(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'category="$categoryId"'};

      Response<dynamic> response;
      if (categoryId == 'qnbj8d6b9lzzpn8') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }

      return response.data['items']
          .map<ProductModel>((jsonObject) => ProductModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}
