import 'package:ecommerce/bloc/home/home_event.dart';
import 'package:ecommerce/bloc/home/home_state.dart';
import 'package:ecommerce/data/repository/banner_repository.dart';
import 'package:ecommerce/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();

  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitializeEvent>((event, emit) async {
      emit(HomeLoadingState());
      var bannerList = await _bannerRepository.getBanners();
      emit(HomeRequestSuccessState(bannerList));
    });
  }
}
