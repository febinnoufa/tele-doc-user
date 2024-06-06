import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:teledocuser/controllers/payment/payment.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Text(
              "Welcome to this page",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Enter amount to be paid",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                controller: controller.amtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount to be paid';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () => controller.openCheckout(),
              child: const Text("Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
