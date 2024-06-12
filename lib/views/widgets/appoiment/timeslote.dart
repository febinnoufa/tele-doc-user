import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';
import 'package:teledocuser/controllers/appoiment/timeselect.dart';

import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';
import 'package:teledocuser/controllers/time/time_controller.dart';
import 'package:teledocuser/model/schedules/shedul.dart';
import 'package:teledocuser/views/screens/payment/payment.dart';

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
            } else if (snapshot.hasError) {
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
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            spacing: 15.0,
                            runSpacing: 15.0,
                            children: [
                              ..._buildTimeSlots(filteredSchedules, 'Morning'),
                              ..._buildTimeSlots(
                                  filteredSchedules, 'Afternoon'),
                              ..._buildTimeSlots(filteredSchedules, 'Evening'),
                              ..._buildTimeSlots(filteredSchedules, 'Night'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            final selectedTime =
                                timeSlotPickerController.selectTime.value;
                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  selectedDate,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  selectedTime != null
                                      ? 'Selected Time: ${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')} '
                                      : 'No time selected',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                  // Get the selected time
                                  final selectedTime = timeSlotPickerController
                                      .selectTime.value
                                      .toString()
                                      .split("(")
                                      .last
                                      .split(")")
                                      .first
                                      .split(":")
                                      .first;
                                  final time = int.parse(selectedTime) < 12
                                      ? "${timeSlotPickerController.selectTime.value.toString().split("(").last.split(")").first} AM"
                                      : "${timeSlotPickerController.selectTime.value.toString().split("(").last.split(")").first} PM";
                                    print(";;;;;;${time}");

                                    

                                  if (selectedTime != null) {
                                    print("$selectedTime ...............");
                                    // Iterate through filtered schedules
                                    for (var schedule in filteredSchedules) {
                                      if (schedule.intervals
                                          .containsKey(time)) {
                                        schedule.intervals[time] = false;
                                        print(
                                            ">>>>>>>>>>>${schedule.intervals.values}");
                                        print("%%%%%%%%%%%true");
                                        await FirebaseFirestore.instance
                                            .collection("approveddoctors")
                                            .doc(dcCntrl.currentdoc.id)
                                            .collection("shedules")
                                            .doc(dateController
                                                .selectedDate.value
                                                .toString()
                                                .split(" ")
                                                .first)
                                            .update({
                                          'intervals': schedule.intervals
                                        });
                                      } else {
                                        print("547");
                                      }
                                    }

                                    Get.to(const PaymentScreen());
                                  } else {}
                                },
                                child: const Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
            }
          },
        );
      }),
    );
  }

  List<Widget> _buildTimeSlots(List<Schedule> schedules, String period) {
    List<Widget> widgets = [];
    for (var schedule in schedules) {
      for (var entry in schedule.intervals.entries) {
        final isAvailable = entry.value;
        final selectedTime = _parseTimeOfDay(entry.key);
        if (_getTimePeriod(selectedTime) == period) {
          widgets.add(
            GestureDetector(
              onTap: isAvailable
                  ? () {
                      timeSlotPickerController.updateSelectTime(selectedTime);
                    }
                  : null,
              child: Obx(() {
                final isSelected =
                    timeSlotPickerController.isSelected(selectedTime);
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.green
                        : isAvailable
                            ? Colors.white
                            : const Color.fromARGB(255, 71, 71, 71),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    entry.key.toString().split('-').first,
                    style: TextStyle(
                      color: isAvailable ? Colors.black : Colors.white,
                    ),
                  ),
                );
              }),
            ),
          );
        }
      }
    }
    return widgets;
  }

  String _getTimePeriod(TimeOfDay time) {
    if (time.hour >= 6 && time.hour < 12) {
      return 'Morning';
    } else if (time.hour >= 12 && time.hour < 17) {
      return 'Afternoon';
    } else if (time.hour >= 17 && time.hour < 21) {
      return 'Evening';
    } else {
      return 'Night';
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
