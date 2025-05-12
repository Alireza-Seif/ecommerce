import 'package:dio/dio.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}  

class AuthenticationRemote implements IAuthenticationDatasource {
  final Dio _dio = locator.get();

  @override
  Future<void> register(String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm,
      });

      if (response.statusCode == 200) {
        // Optionally await login if you want to handle the result
        await login(username, password);
      } else {
        throw ApiException(response.statusCode, 'Registration failed');
      }
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode ?? 0,
        ex.response?.data?['message'] ?? 'Unknown error occurred',
      );
    } catch (ex) {
      throw ApiException(0, 'Unknown error occurred');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post('collections/users/auth-with-password', data: {
        'identity': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        return response.data?['token'] ?? '';
      } else {
        throw ApiException(response.statusCode, 'Login failed');
      }
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
