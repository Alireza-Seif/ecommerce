import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/authentication_datasource.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';
import 'package:ecommerce/util/auth_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository extends IAuthRepository {
  final IAuthenticationDatasource _datasource = locator.get();
  final SharedPreferences _sharedPref = locator.get();
  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('ثبت نام انجام شد!');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('شما با موفقیت وارد شدید');
      } else {
        return left('خطا در دریافت توکن');
      }
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا در ورود به سیستم');
    } catch (e) {
      return left('خطای ناشناخته: $e');
    }
  }
}
