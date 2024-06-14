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


}
