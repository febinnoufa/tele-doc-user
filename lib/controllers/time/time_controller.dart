import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlotPickerController extends GetxController {

  Rx<TimeOfDay?> selectTime = Rx<TimeOfDay?>(null);

  void updateSelectTime(TimeOfDay? value) {
  

    selectTime.value = value;
   
  }


  bool isSelected(TimeOfDay time) {
 
    return selectTime.value == time;
  }
}
