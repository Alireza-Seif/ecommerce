
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce/data/datasource/authentication_datasource.dart';
import 'package:ecommerce/data/repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';

var locator= GetIt.instance;

Future<void> getItInit() async{
locator.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));


//datasources
locator.registerFactory<IAuthenticcationDatasource>(() => AuthenticcationRemote());


//repositories
locator.registerFactory<IAuthRepository>(() => AuthencticationRepository());
}