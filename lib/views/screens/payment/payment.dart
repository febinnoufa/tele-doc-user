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
            const AppBarWidget(title: "All Details"),
            AllSelctedDetailsForAppoiment(),
            const SizedBox(height: 30,),

            const Text("Please verify that the details provided are correct."),
             const SizedBox(height: 10,),
            const Text(" Upon payment of the fees, your appointment will"),
             const SizedBox(height: 10,),
            const Text("  be successfully scheduled")
            // const SizedBox(
            //   height: 150,
            // ),
            // const Text(
            //   "All Deatials",
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     cursorColor: Colors.white,
            //     autofocus: false,
            //     decoration: const InputDecoration(
            //       labelText: "Enter amount to be paid",
            //       labelStyle: TextStyle(fontSize: 15, color: Colors.white),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.white, width: 1),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: Colors.white,
            //           width: 1,
            //         ),
            //       ),
            //       errorStyle: TextStyle(
            //         color: Colors.red,
            //         fontSize: 15,
            //       ),
            //     ),
            //     controller: controller.amtController,
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter amount to be paid';
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // ElevatedButton(
            //   onPressed: () => controller.openCheckout(),
            //   child: const Text("Pay"),
            // ),
          ],
        ),
      ),
    );
  }
}
