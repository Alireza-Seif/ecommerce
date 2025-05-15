import 'package:dio/dio.dart';
import 'package:ecommerce/data/datasource/authentication_datasource.dart';
import 'package:ecommerce/data/datasource/banner_datasource.dart';
import 'package:ecommerce/data/datasource/category_datasource.dart';
import 'package:ecommerce/data/repository/authentication_repository.dart';
import 'package:ecommerce/data/repository/banner_repository.dart';
import 'package:ecommerce/data/repository/category_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
//components
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
//datasources
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());

  locator
      .registerFactory<ICategoryDataSource>(() => CategoryRemoteDatasource());

  locator.registerFactory<IBannerDataSource>(() => BannerRemoteDataSource());

//repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());

  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());

  
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
}
