import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TimeSlotPickerController extends GetxController {
  Rx<DateTime?> selectTime = Rx<DateTime?>(null);

  void updateSelectTime(DateTime? value) {
    selectTime.value = value;
  }

    Future isDoctorAvailable(String docId, String selectedDate) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('schedule')
        .where('docId', isEqualTo: docId)
        .where('date', isEqualTo: selectedDate)
        .get();
        
    return querySnapshot.docs;
  }
}
