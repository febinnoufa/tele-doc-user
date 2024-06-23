import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';

class AppointmentCard extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final Map<String, dynamic> appointment;
  final DateTime appointmentDateTime;

  const AppointmentCard({
    required this.doctorName,
    required this.specialty,
    required this.appointment,
    required this.appointmentDateTime,
    Key? key,
  }) : super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  late Timer _timer;
  late Duration _timeRemaining;

  final AppointmentController cntr = Get.put(AppointmentController());

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.appointmentDateTime.difference(DateTime.now());
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining = widget.appointmentDateTime.difference(DateTime.now());
        if (_timeRemaining.isNegative) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) {
      return 'Appointment Passed';
    } else {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final days = duration.inDays;
      final hours = twoDigits(duration.inHours.remainder(24));
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return '$days day $hours:$minutes:$seconds';
    }
  }

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
                Text(
                  _formatDuration(_timeRemaining),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
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
                ElevatedButton(
                  onPressed: () {
                    cntr.deleteAppointmentDetails(
                        widget.appointment['appoimnet_id'] ?? '');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(100, 20), // Adjust the width and height here
                    ),
                  ),
                  child: const Text("Cancel"),
                )
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
