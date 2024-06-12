import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/appoiment/timeselect.dart';

class ScheduleView extends StatelessWidget {
  final TimeselectController controller = Get.put(TimeselectController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.schedules.length,
        itemBuilder: (context, index) {
          final schedule = controller.schedules[index];
          return ListTile(
            title: Text('${schedule.date}: ${schedule.startTime} - ${schedule.endTime}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: schedule.intervals.entries.map((entry) {
                return Text('${entry.key}: ${entry.value ? "Available" : "Unavailable"}');
              }).toList(),
            ),
          );
        },
      );
    });
  }
}
