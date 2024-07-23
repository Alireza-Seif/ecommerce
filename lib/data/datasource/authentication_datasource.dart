import 'package:dio/dio.dart';
import 'package:ecommerce/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IAuthenticcationDatasource{
  Future<void> register(String username,String password,String passwordConfirm);
}

class AuthenticcationRemote implements IAuthenticcationDatasource{
  final Dio _dio = locator.get();
  
  @override
  Future<void> register(String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
      'username': username,
      'password': password,
      'passwordConfirm': passwordConfirm,
    });
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    }
  }

  
}
