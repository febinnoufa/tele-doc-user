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

  // ignore: prefer_typing_uninitialized_variables
  var image;


  // StoreAppointmentDetails In Firbase
  //************************************************************************** */

  Future<void> storeAppointmentDetails() async {
    try {
      final documentId = DateTime.now().toString();
      String formattedTime =
          "${timeController.selectTime.value!.hour.toString().padLeft(2, '0')}:${timeController.selectTime.value!.minute.toString().padLeft(2, '0')}";

      FirebaseFirestore.instance
          .collection('appointments')
          .doc(documentId)
          .set({
        'image': image,
        'appoimnet_id': documentId,
        'patient_name': nameController.text,
        'contact_number': contactController.text,
        'reason_for_appointment': reasonController.text,
        'user': FirebaseAuth.instance.currentUser!.uid,
        'docter': doctorController.currentdoc.id,
        'created_at': FieldValue.serverTimestamp(),
        'date': dateController.selectedDate.value.toString().split(" ").first,
        'time': formattedTime,
        'end': false
      });

      Get.snackbar('Success', 'Appointment details saved successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save appointment details',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // if once one time is selected then change color
  //************************************************************************** */

  disabletime() async {
    try {
      await FirebaseFirestore.instance
          .collection("approveddoctors")
          .doc(doctorController.currentdoc.id)
          .collection("shedules")
          .doc(dateController.selectedDate.value.toString().split(" ").first)
          .update({
        // 'intervals':
      });
      // ignore: empty_catches
    } catch (e) {}
  }
 

  // DelateAppointmentDetails In Firbase
  //************************************************************************** */

  Future<void> deleteAppointmentDetails(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(documentId)
          .delete();

      Get.snackbar('Success', 'Appointment details deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete appointment details',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
