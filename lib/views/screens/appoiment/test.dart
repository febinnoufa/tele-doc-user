import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/appoiment/timeselect.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/controllers/time/time_controller.dart';
import 'package:teledocuser/model/schedules/shedul.dart';
import 'package:teledocuser/views/widgets/appoiment/colonder.dart';
import 'package:teledocuser/views/widgets/appoiment/timeslote.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

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
      body: Column(
        children: [
          CalendarWidget(),
          const SizedBox(height: 30),
          const SizedBox(height: 10.0),
          TimeSelectWidget()
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: GetBuilder<DateController>(
          //     builder: (dateController) {
          //       return FutureBuilder<void>(
          //         future: timecontroller.fetchUserSchedules(),
          //         builder: (context, snapshot) {
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return const Center(child: CircularProgressIndicator());
          //           } else {
          //             List<Schedule> filteredSchedules = timecontroller
          //                 .schedules
          //                 .where((schedule) =>
          //                     schedule.date ==
          //                     dateController.selectedDate.value
          //                         .toString()
          //                         .split(" ")
          //                         .first)
          //                 .toList();

          //             return filteredSchedules.isEmpty
          //                 ? const Text(
          //                     'No schedules available for the selected date')
          //                 : Column(
          //                     children: [
          //                       GetX<TimeSlotPickerController>(
          //                        builder: (controller) =>  TimesSlotGridViewFromInterval(
          //                           initTime: timeSlotPickerController.selectTime.value ?? DateTime.now(),
          //                           crossAxisCount: 4,
          //                           onChange: (value) {
          //                             timeSlotPickerController.updateSelectTime(value);
          //                           },
          //                           timeSlotInterval: TimeSlotInterval(
          //                             start: _parseTimeOfDay(filteredSchedules[0].startTime),
          //                             end: _parseTimeOfDay(filteredSchedules[0].endTime),
          //                             interval: const Duration(minutes: 30),
          //                           ),
          //                           selectedColor: Colors.green, // Specify the color for selected time
          //                         ),
          //                       ),
          //                       const SizedBox(height: 20),
          //                       Obx(() {
          //                         final selectedTime = timeSlotPickerController.selectTime.value;
          //                         return Text(
          //                           selectedTime != null
          //                               ? 'Selected Time: ${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}'
          //                               : 'No time selected',
          //                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //                         );
          //                       }),
          //                     ],
          //                   );
          //           }
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
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
