import 'package:app_links/app_links.dart';
import 'package:ecommerce/util/extensions/string_extensions.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest();
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinpalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();

  @override
  Future<void> initPaymentRequest() async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(1000);
    _paymentRequest.setDescription('this is test for ecommerce application');
    _paymentRequest.setCallbackURL('expertflutter://shop');
    _paymentRequest.setMerchantID('test');
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri, data) {
        if (status == 100) {
          // launchUrl(Uri.parse(paymentGatewayUri!)
        }
      },
    );
  }

  @override
  Future<void> verifyPaymentRequest() async {
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
  }
}

class PaypalPaymentHandler extends PaymentHandler{
  @override
  Future<void> initPaymentRequest() {
    // TODO: implement initPaymentRequest
    throw UnimplementedError();
  }

  @override
  Future<void> sendPaymentRequest() {
    // TODO: implement sendPaymentRequest
    throw UnimplementedError();
  }

  @override
  Future<void> verifyPaymentRequest() {
    // TODO: implement verifyPaymentRequest
    throw UnimplementedError();
  }
}