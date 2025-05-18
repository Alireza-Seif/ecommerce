import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/banner_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IBannerDataSource {
  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDataSource extends IBannerDataSource {
  Dio _dio = locator.get();
  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<BannerModel>((jsonObject) => BannerModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
