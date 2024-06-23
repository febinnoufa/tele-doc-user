import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';
import 'package:teledocuser/views/screens/prescription/prescription.dart';

class AppointmentCardPast extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final Map<String, dynamic> appointment;
  final DateTime appointmentDateTime;

  const AppointmentCardPast({
    required this.doctorName,
    required this.specialty,
    required this.appointment,
    required this.appointmentDateTime,
    Key? key,
  }) : super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCardPast> {
  final AppointmentController cntr = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dr ${widget.doctorName}",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Date"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.appointment['date'] ?? 'N/A',
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Time"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.appointment['time'] ?? 'N/A',
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(
                  width: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Category"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.specialty,
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Reason for Appointment"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.appointment['reason_for_appointment'] ?? 'N/A',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(SHowAllDataInPrescription(
                    id: widget.appointment['appoimnet_id'],
                  ));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(greenColor),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(200, 20), // Adjust the width and height here
                  ),
                ),
                child: const Text(
                  "Show Prescription",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
