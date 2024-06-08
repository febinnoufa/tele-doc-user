import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/controllers/time/datecontroller.dart';
import 'package:teledocuser/controllers/time/time_controller.dart';

class AppointmentController extends GetxController {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final reasonController = TextEditingController();
  final DoctorController doctorController = Get.put(DoctorController());
  final DateController dateController = Get.put(DateController());
  final TimeSlotPickerController timeController =
      Get.put(TimeSlotPickerController());

  Future<void> storeAppointmentDetails() async {
    try {
      CollectionReference appointments =
          FirebaseFirestore.instance.collection('appointments');
      await appointments.add({
        'patient_name': nameController.text,
        'contact_number': contactController.text,
        'reason_for_appointment': reasonController.text,
        'user': FirebaseAuth.instance.currentUser!.uid,
        'docter': doctorController.currentdoc.id,
        'created_at': FieldValue.serverTimestamp(),
        'date': dateController.selectedDate.value.toString().split(" ").first,
        'time':
            "${timeController.selectTime.value!.hour}:${timeController.selectTime.value!.minute.toString().padLeft(2, '0')}"
        //timeController.selectTime.value.toString().split(" ").last
      });
      Get.snackbar('Success', 'Appointment details saved successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save appointment details',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
