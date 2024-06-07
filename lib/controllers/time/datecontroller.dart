import 'package:get/get.dart';

class DateController extends GetxController {
  var selectedDate = DateTime.now().obs;

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    
  }
}
