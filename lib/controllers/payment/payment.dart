import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';
import 'package:teledocuser/controllers/time/time_controller.dart';
import 'package:teledocuser/views/screens/appoiment/successpage.dart'; // Import Get for navigation

class PaymentController extends GetxController {
  late Razorpay _razorpay;

  final TextEditingController amtController = TextEditingController();

  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  final DateController dateController = Get.put(DateController());
  final TimeSlotPickerController timecontroller =
      Get.put(TimeSlotPickerController());

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
    // Navigate to the success page
    appointmentController.storeAppointmentDetails();
    appointmentController.disabletime();
    appointmentController.contactController.clear();
    appointmentController.nameController.clear();
    appointmentController.reasonController.clear();
    dateController.selectedDate.value = DateTime.now();

    Get.offAll(() => const SuccessPage());
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
    int amount = 200;
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

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
