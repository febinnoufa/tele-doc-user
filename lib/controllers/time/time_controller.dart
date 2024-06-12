import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlotPickerController extends GetxController {
  Rx<TimeOfDay?> selectTime = Rx<TimeOfDay?>(null);

  void updateSelectTime(TimeOfDay? value) {
    selectTime.value = value;
    print("Selected Time: ${selectTime.value}");
  }
}
