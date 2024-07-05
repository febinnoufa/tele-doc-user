import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:teledocuser/controllers/payment/payment.dart';
import 'package:teledocuser/views/widgets/appbar/appbar.dart';
import 'package:teledocuser/views/widgets/appoiment/details_appoment.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(title: "All Details",backarrow: true),
            AllSelctedDetailsForAppoiment(),
            const SizedBox(
              height: 30,
            ),
            const Text("Please verify that the details provided are correct."),
            const SizedBox(
              height: 10,
            ),
            const Text(" Upon payment of the fees, your appointment will"),
            const SizedBox(
              height: 10,
            ),
            const Text("  be successfully scheduled")
          ],
        ),
      ),
    );
  }
}
