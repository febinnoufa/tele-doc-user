import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (date) {
          print('Selected date: $date');
        },
      ),
    );
  }
}
