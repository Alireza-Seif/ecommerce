import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/authentication_datasource.dart';
import 'package:ecommerce/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IAuthRepository {
  Future<Either<ApiException, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(String username, String password);
}

class AuthencticationRepository extends IAuthRepository {
  final IAuthenticcationDatasource _datasource = locator.get();

  @override
  Future<Either<ApiException, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register('alireza', '12345678', '12345678');
      return right('ثبت نام انجام شد');
    } on ApiException catch (ex) {
      return left((ex.message ?? 'خطا محتوا خالی است') as ApiException);
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await await _datasource.login(username, password);
      if (token.isNotEmpty) {
        return right('شما وارد شده اید');
      } else {
        return left('خطایی در ورود پیش آمده');
      }
    } on ApiException catch (ex) {
      return left('${ex.message}');
    }
  }
}
