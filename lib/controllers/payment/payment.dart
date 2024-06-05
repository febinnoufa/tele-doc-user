import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;

  final TextEditingController amtController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Successful ${response.paymentId!}",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Error ${response.message!}",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "External Wallet ${response.walletName!}",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void openCheckout() {
    if (amtController.text.isNotEmpty) {
      int amount = int.parse(amtController.text);
      amount *= 100;
      var options = {
        'key': 'rzp_test_5CvknA4rDqeKqA',
        'amount': amount,
        'name': 'teddoc',
        'prefill': {'contact': '7012845511', 'email': 'test@razorpay.com'},
        'external': {
          'wallets': ['paytm']
        }
      };
      try {
        _razorpay.open(options);
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
