import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/controllers/time/time_controller.dart';
import 'package:teledocuser/views/widgets/appoiment/colonder.dart';

import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

class TimeSlotPickerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TimeSlotPickerController controller = Get.put(TimeSlotPickerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          CalendarWidget(),
        const  SizedBox(height: 30,),
        
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GetX<TimeSlotPickerController>(
              builder: (controller) => TimesSlotGridViewFromInterval(
                locale: "en",
                initTime: controller.selectTime.value ?? DateTime.now(),
                crossAxisCount: 4,
                timeSlotInterval: const TimeSlotInterval(
                  start: TimeOfDay(hour: 9, minute: 30),
                  end: TimeOfDay(hour: 22, minute: 0),
                  interval: Duration(minutes: 30),
                ),
             
                onChange: (value) {
                  controller.updateSelectTime(value);
                },
              ),
            ),
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius:
                    BorderRadius.circular(8), 
              ),
              child: TextButton(
                onPressed: () {
                  Get.to(TimeSlotPickerDemo());
                 // Get.to( AppoimentBookingPage());
                  
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
