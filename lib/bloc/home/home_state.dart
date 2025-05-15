import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/banner_model.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}


class HomeInitState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerModel>> bannerList;
  HomeRequestSuccessState(this.bannerList);
}
