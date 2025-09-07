import 'package:app_links/app_links.dart';
import 'package:ecommerce/util/extensions/string_extensions.dart';
import 'package:ecommerce/util/url_handler.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest();
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinpalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  UrlHandler urlHandler;

  ZarinpalPaymentHandler(
    this.urlHandler,
  );

  String? _authority;
  String? _status;

  @override
  Future<void> initPaymentRequest() async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(1000);
    _paymentRequest.setDescription('this is test for ecommerce application');
    _paymentRequest.setCallbackURL('expertflutter://shop');
    _paymentRequest.setMerchantID('test');

    AppLinks().stringLinkStream.listen(
      (deeplink) {
        if (deeplink.toLowerCase().contains('authority')) {
          _authority = deeplink.extractValueFromQuery('Authority');
          _status = deeplink.extractValueFromQuery('Status');

          verifyPaymentRequest();
        }
      },
    );
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri, data) {
        if (status == 100) {
          urlHandler.openUrl(paymentGatewayUri!);
        }
      },
    );
  }

  @override
  Future<void> verifyPaymentRequest() async {
    if (_status == null || _authority == null) {
      print('No payment data found for verification');
      return;
    }

    ZarinPal().verificationPayment(
      _status!,
      _authority!,
      _paymentRequest,
      (isPaymentSuccess, refID, paymentRequest, data) {
        if (isPaymentSuccess) {
          print('Payment successful, refID: $refID');
        } else {
          print('Payment failed');
        }
      },
    );
  }
}
