// CalendarWidget
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/appoiment/timeselect.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';
import 'package:teledocuser/controllers/time/time_controller.dart';


class CalendarWidget extends StatelessWidget {
  CalendarWidget({Key? key}) : super(key: key);

  final DateController cntr = Get.find<DateController>();
   final TimeSlotPickerController timeSlotPickerController = Get.put(TimeSlotPickerController());
    final TimeselectController timecontroller = Get.put(TimeselectController());


  @override
  Widget build(BuildContext context) {
    return Center(
      child: EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (date) {
          cntr.setSelectedDate(date);
          timeSlotPickerController.selectTime.value = null;
        },
      ),
    );
  }
}