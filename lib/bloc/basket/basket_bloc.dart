import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/basket/basket_event.dart';
import 'package:ecommerce/bloc/basket/basket_state.dart';
import 'package:ecommerce/data/repository/basket_repository.dart';
import 'package:ecommerce/di/di.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();
  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>(
      (event, emit) async {
        var basketItemList = await _basketRepository.getAllBasketItem();
        emit(BasketDataFetchedState(basketItemList));
      },
    );
  }
}
