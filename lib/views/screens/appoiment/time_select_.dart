import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/appoiment/timeselect.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/controllers/time/time_controller.dart';
import 'package:teledocuser/views/widgets/appoiment/colonder.dart';
import 'package:teledocuser/views/widgets/appoiment/timeslote.dart';


class DoctorScheduleScreen extends StatelessWidget {
  final DoctorController dcCntrl = Get.put(DoctorController());
  final DateController dateController = Get.put(DateController());
  final TimeselectController timecontroller = Get.put(TimeselectController());
  final TimeSlotPickerController timeSlotPickerController =
      Get.put(TimeSlotPickerController());

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarWidget(),
            const SizedBox(height: 30),
            const SizedBox(height: 10.0),
            TimeSelectWidget(),
            
           
          ],
        ),
      ),
    );
  }

  // TimeOfDay _parseTimeOfDay(String time) {
  //   final parts = time.split(':');
  //   var hour = int.parse(parts[0]);
  //   final minute = int.parse(parts[1].split(' ')[0]); // Extract minutes
  //   final isPM = parts[1].contains('PM'); // Check if PM
  //   // Adjust hour for PM
  //   if (isPM && hour < 12) {
  //     hour += 12;
  //   }
  //   return TimeOfDay(
  //       hour: hour % 24, minute: minute); // Modulus to handle 12 PM
  // }
}
