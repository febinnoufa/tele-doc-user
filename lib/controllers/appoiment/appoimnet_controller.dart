import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';

class AppointmentController extends GetxController {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final reasonController = TextEditingController();
  final DoctorController doctorController = Get.put(DoctorController());

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
      });
      Get.snackbar('Success', 'Appointment details saved successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save appointment details',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
