import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teledocuser/model/schedules/shedul.dart';
import 'package:teledocuser/views/widgets/appoiment/colonder.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

// ignore: must_be_immutable
class DoctorScheduleScreen extends StatelessWidget {
  final DoctorController dcCntrl = Get.put(DoctorController());
  final DateController dateController = Get.put(DateController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DoctorScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          CalendarWidget(),
          const SizedBox(height: 30),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GetBuilder<DateController>(
              builder: (dateController) {
                return FutureBuilder<void>(
                  future: fetchUserSchedules(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List<Schedule> filteredSchedules = _schedules
                          .where((schedule) =>
                              schedule.date ==
                              dateController.selectedDate.value
                                  .toString()
                                  .split(" ")
                                  .first)
                          .toList();

                      return filteredSchedules.isEmpty
                          ? const Text('No schedules available for the selected date')
                          : TimesSlotGridViewFromInterval(
                              initTime: DateTime.now(),
                              crossAxisCount: 4,
                              onChange: (value) {
                                print(".........................$value");
                              },
                              timeSlotInterval: TimeSlotInterval(
                                start: _parseTimeOfDay(
                                    filteredSchedules[0].startTime),
                                end: _parseTimeOfDay(
                                    filteredSchedules[0].endTime),
                                interval: const Duration(minutes: 30),
                              ),
                            );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Schedule> _schedules = [];

  Future<void> fetchUserSchedules() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      QuerySnapshot snapshot = await _db
          .collection("approveddoctors")
          .doc(dcCntrl.currentdoc.id)
          .collection("shedules")
          .orderBy('createdAt', descending: true)
          .get();

      _schedules =
          snapshot.docs.map((doc) => Schedule.fromFirestore(doc)).toList();
    }
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    var hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]); // Extract minutes
    final isPM = parts[1].contains('PM'); // Check if PM
    // Adjust hour for PM
    if (isPM && hour < 12) {
      hour += 12;
    }
    return TimeOfDay(
        hour: hour % 24, minute: minute); // Modulus to handle 12 PM
  }
}


