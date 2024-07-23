import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/authentication_datasource.dart';
import 'package:ecommerce/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IAuthRepository {
  Future<Either<ApiException, String>> register(
      String username, String password, String passwordConfirm);
}

class AuthencticationRepository extends IAuthRepository {
  final IAuthenticcationDatasource _datasourcce = locator.get();

  @override
  Future<Either<ApiException, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasourcce.register('alireza', '12345678', '12345678');
      return right('ثبت نام انجام شد');
    } on ApiException catch (ex) {
      return left((ex.message ?? 'خطا محتوا خالی است') as ApiException);
    }
  }
}
