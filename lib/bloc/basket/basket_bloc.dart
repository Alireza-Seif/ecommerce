import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/basket/basket_event.dart';
import 'package:ecommerce/bloc/basket/basket_state.dart';
import 'package:ecommerce/data/repository/basket_repository.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/payment_handler.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();
  PaymentHandler paymentHandler = ZarinpalPaymentHandler();

  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>(
      (event, emit) async {
        var basketItemList = await _basketRepository.getAllBasketItem();
        var finalBasketPrice = await _basketRepository.getBasketFinalPrice();
        emit(BasketDataFetchedState(basketItemList, finalBasketPrice));
      },
    );

    on<BasketPaymentInitEvent>((event, emit) async {
      paymentHandler.initPaymentRequest();
    });
    on<BasketPaymentRequestEvent>((event, emit) async {
      paymentHandler.sendPaymentRequest();
    });
  }
}
