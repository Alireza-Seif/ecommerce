import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/product_image_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImageModel>> getGallery();
}

class ProductDetailRemoteDatasource extends IProductDetailDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImageModel>> getGallery() async {
    try {
      Map<String, dynamic> qParams = {'filter': 'product_id="78n4wqor3hhnkju"'};
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams );
      return response.data['items']
          .map<ProductImageModel>(
              (jsonObject) => ProductImageModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
