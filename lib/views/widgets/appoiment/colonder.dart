// CalendarWidget
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget({Key? key}) : super(key: key);

  final DateController cntr = Get.find<DateController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (date) {
          cntr.setSelectedDate(date);
          print('Selected date: $date');
        },
      ),
    );
  }
}