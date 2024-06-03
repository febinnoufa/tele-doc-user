import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';


class PaymentAndDeatilsCardWidget extends StatelessWidget {
  PaymentAndDeatilsCardWidget({super.key});
  final DoctorController cntr = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust radius as needed
                child: Image.network(
                  cntr.currentdoc.profile,
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.cover, // Maintain aspect ratio
                ),
              ),

              // ClipRRect(
              //   borderRadius: BorderRadius.circular(35.0),
              //   child: Image.network(
              //     cntr.currentdoc.profile,
              //     height: 70,
              //     width: 70,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr  ${cntr.currentdoc.name}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      cntr.currentdoc.specialist,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.currency_rupee_rounded, color: Colors.grey),
                  Text(
                    "200.00",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
