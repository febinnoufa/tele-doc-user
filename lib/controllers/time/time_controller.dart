import 'package:get/get.dart';

class TimeSlotPickerController extends GetxController {
  Rx<DateTime?> selectTime = Rx<DateTime?>(null);

  void updateSelectTime(DateTime? value) {
    selectTime.value = value;
  }
}
