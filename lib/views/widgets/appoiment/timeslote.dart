import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';

import 'package:teledocuser/controllers/appoiment/timeselect.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';
import 'package:teledocuser/controllers/time/time_controller.dart';
import 'package:teledocuser/model/schedules/shedul.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

class TimeSelectWidget extends StatelessWidget {
  TimeSelectWidget({Key? key}) : super(key: key);

  final DoctorController dcCntrl = Get.put(DoctorController());
  final DateController dateController = Get.put(DateController());
  final TimeselectController timecontroller = Get.put(TimeselectController());
  final TimeSlotPickerController timeSlotPickerController =
      Get.put(TimeSlotPickerController());
  final AppointmentController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() {
        final selectedDate =
            dateController.selectedDate.value.toString().split(" ").first;

        return FutureBuilder<void>(
          future: timecontroller.fetchUserSchedules(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Schedule> filteredSchedules = timecontroller.schedules
                    .where((schedule) => schedule.date == selectedDate)
                    .toList();

                return filteredSchedules.isEmpty
                    ? const Center(
                        child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                          ),
                          Text('No schedules available for the selected date'),
                        ],
                      ))
                    : Column(
                        children: [
                          GetX<TimeSlotPickerController>(
                            builder: (controller) =>
                                TimesSlotGridViewFromInterval(
                              initTime:
                                  timeSlotPickerController.selectTime.value ??
                                      DateTime.now(),
                              crossAxisCount: 4,
                              onChange: (value) {
                                timeSlotPickerController
                                    .updateSelectTime(value);
                              },
                              timeSlotInterval: TimeSlotInterval(
                                start: _parseTimeOfDay(
                                    filteredSchedules[0].startTime),
                                end: _parseTimeOfDay(
                                    filteredSchedules[0].endTime),
                                interval: const Duration(minutes: 30),
                              ),
                              selectedColor: Colors
                                  .green, // Specify the color for selected time
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            final selectedTime =
                                timeSlotPickerController.selectTime.value;
                            return Column(
                              children: [
                                Text(selectedDate),
                                Text(
                                  selectedTime != null
                                      ? 'Selected Time: ${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')} '
                                      : 'No time selected',
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  await controller.storeAppointmentDetails();
                                  controller.contactController.clear();
                                  controller.nameController.clear();
                                  controller.reasonController.clear();
                                },
                                child: const Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
              }
            }
          },
        );
      }),
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
