import 'package:dio/dio.dart';
import 'package:ecommerce/bloc/basket/basket_bloc.dart';
import 'package:ecommerce/data/datasource/authentication_datasource.dart';
import 'package:ecommerce/data/datasource/banner_datasource.dart';
import 'package:ecommerce/data/datasource/basket_datasource.dart';
import 'package:ecommerce/data/datasource/category_datasource.dart';
import 'package:ecommerce/data/datasource/category_product_datasource.dart';
import 'package:ecommerce/data/datasource/product_datasource.dart';
import 'package:ecommerce/data/datasource/product_detail_datasource.dart';
import 'package:ecommerce/data/repository/authentication_repository.dart';
import 'package:ecommerce/data/repository/banner_repository.dart';
import 'package:ecommerce/data/repository/basket_repository.dart';
import 'package:ecommerce/data/repository/category_product_repository.dart';
import 'package:ecommerce/data/repository/category_repository.dart';
import 'package:ecommerce/data/repository/product_detail_repository.dart';
import 'package:ecommerce/data/repository/product_repository.dart';
import 'package:ecommerce/util/payment_handler.dart';
import 'package:ecommerce/util/url_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
//util
  _initUnits();

//components
 await  _initComponents();

//datasources
  _initDataSources();

//repositories
  _initRepositories();

  //Bloc
  locator
      .registerSingleton<BasketBloc>(BasketBloc(locator.get(), locator.get()));
}

//util
void _initUnits() {
  locator.registerSingleton<PaymentHandler>(
      ZarinpalPaymentHandler(locator.get(), locator.get()));
  locator.registerSingleton<BasketRepository>(BasketRepository());
  locator.registerSingleton<UrlHandler>(UrlLauncher());
}

//components
Future<void> _initComponents() async {
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

//datasources
void _initDataSources() {
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());

  locator
      .registerFactory<ICategoryDataSource>(() => CategoryRemoteDatasource());

  locator.registerFactory<IBannerDataSource>(() => BannerRemoteDataSource());

  locator.registerFactory<IProductDataSource>(() => ProductRemoteDatasource());

  locator.registerFactory<IProductDetailDatasource>(
      () => ProductDetailRemoteDatasource());

  locator.registerFactory<ICategoryProductDataSource>(
      () => CategoryProductRemoteDatasource());

  locator.registerFactory<IBasketDatasource>(() => BasketLocDatasource());
}

//repositories
void _initRepositories() {
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());

  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());

  locator.registerFactory<IBannerRepository>(() => BannerRepository());

  locator.registerFactory<IProductRepository>(() => ProductRepository());

  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository());

  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());

  locator.registerFactory<IBasketRepository>(() => BasketRepository());
}
