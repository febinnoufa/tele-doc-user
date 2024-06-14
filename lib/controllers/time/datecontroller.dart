
import 'package:get/get.dart';
import 'package:teledocuser/controllers/appoiment/timeselect.dart';

class DateController extends GetxController {
  final TimeselectController timecontroller = Get.put(TimeselectController());
  var selectedDate = DateTime.now().obs;

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    timecontroller.fetchUserSchedules(); 
  }
}