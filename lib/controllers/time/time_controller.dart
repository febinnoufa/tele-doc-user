import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlotPickerController extends GetxController {

  Rx<TimeOfDay?> selectTime = Rx<TimeOfDay?>(null);

  void updateSelectTime(TimeOfDay? value) {
  

    selectTime.value = value;
   // print("Selected Time...................: ${selectTime.value!.hour}:${selectTime.value!.minute==0?"00":selectTime.value!.minute} ${selectTime.value!.hour < 12 ? "AM" : "PM"}");
  }

  // Method to check if a time slot is selected
  bool isSelected(TimeOfDay time) {
   // print("!!!!!!!!!!!!!!!!!!!!${time}");
    return selectTime.value == time;
  }
}
