import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:ecommerce/bloc/basket/basket_event.dart';
import 'package:ecommerce/bloc/basket/basket_state.dart';
import 'package:ecommerce/data/repository/basket_repository.dart';
import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/util/extensions/string_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();
  final PaymentRequest _paymentRequest = PaymentRequest();

  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>(
      (event, emit) async {
        var basketItemList = await _basketRepository.getAllBasketItem();
        var finalBasketPrice = await _basketRepository.getBasketFinalPrice();
        emit(BasketDataFetchedState(basketItemList, finalBasketPrice));
      },
    );

    on<BasketPaymentInitEvent>((event, emit) async {
      _paymentRequest.setIsSandBox(true);
      _paymentRequest.setAmount(1000);
      _paymentRequest.setDescription('this is test for ecommerce application');
      _paymentRequest.setCallbackURL('expertflutter://shop');
      _paymentRequest.setMerchantID('test');

      AppLinks().stringLinkStream.listen(
        (deeplink) {
          if (deeplink.toLowerCase().contains('authority')) {
            String? authority = deeplink.extractValueFromQuery('Authority');
            String? status = deeplink.extractValueFromQuery('Status');
            // verifyPaymentRequest();
            ZarinPal().verificationPayment(
              status!,
              authority!,
              _paymentRequest,
              (isPaymentSuccess, refID, paymentRequest, data) {
                if (isPaymentSuccess) {
                  print(refID);
                } else {
                  print('error');
                }
              },
            );
          }
        },
      );
    });
    on<BasketPaymentRequestEvent>((event, emit) async {
      ZarinPal().startPayment(_paymentRequest,
          (status, paymentGatewayUri, data) {
        if (status == 100) {
          launchUrl(Uri.parse(paymentGatewayUri!),
              mode: LaunchMode.externalApplication);
        }
      });
    });
  }
}
