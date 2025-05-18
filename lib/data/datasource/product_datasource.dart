import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IProductDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getHottest();
  Future<List<ProductModel>> getBeastSeller();
}

class ProductRemoteDatasource extends IProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<ProductModel>((jsonObject) => ProductModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<ProductModel>> getBeastSeller() async {
    try {
      Map<String, String> qParams = {
        'filter': 'popularity="Best Seller"',
      };
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);
      return response.data['items']
          .map<ProductModel>((jsonObject) => ProductModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<ProductModel>> getHottest() async {
    try {
      Map<String, String> qParams = {
        'filter': 'popularity="Hotest"',
      };
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);
      return response.data['items']
          .map<ProductModel>((jsonObject) => ProductModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
