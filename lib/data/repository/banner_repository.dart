import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/datasource/banner_datasource.dart';
import 'package:ecommerce/data/model/banner_model.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/api_exception.dart';

abstract class IBannerRepository{
  Future<Either<String,List<BannerModel>>> getBanners();
}

class BannerRepository extends IBannerRepository{
  final IBannerDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<BannerModel>>> getBanners() async{
    try {
      var response = await _dataSource.getBanners();
      return right(response);
      
    }on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
      
    }
  }
}