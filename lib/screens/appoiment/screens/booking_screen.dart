import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/screens/appoiment/widgets/payment_card.dart';
import 'package:teledocuser/servises/doctor_controller.dart';

class AppoimentBookingPage extends StatelessWidget {
   AppoimentBookingPage({super.key});
  final DoctorController cntr=Get.put(DoctorController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Appointment",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
       const SizedBox(height: 35,),
        
        PaymentAndDeatilsCardWidget()
      ],),
    ));
  }
}
