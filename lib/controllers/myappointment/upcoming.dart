import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpcomingAppointmentsController extends GetxController {
  var appointments = <QueryDocumentSnapshot>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }



   // fetch appointment
  //************************************************************************** */

  Future<void> fetchAppointments() async {
    try {
      isLoading(true);
      CollectionReference appointmentsCollection =
          FirebaseFirestore.instance.collection('appointments');
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot querySnapshot = await appointmentsCollection
          .where('user', isEqualTo: currentUserId)
          .get();

      appointments.assignAll(querySnapshot.docs);
    } catch (e) {
      errorMessage('Failed to retrieve appointment details');
      Get.snackbar('Error', 'Failed to retrieve appointment details',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }



  // get Doctor details
  //************************************************************************** */

  Future<DocumentSnapshot> getDoctorDetails(String doctorId) async {
    try {
      if (doctorId.isNotEmpty) {
        CollectionReference doctors =
            FirebaseFirestore.instance.collection('approveddoctors');
        DocumentSnapshot doc = await doctors.doc(doctorId).get();
        if (doc.exists) {
          return doc;
        } else {
          throw ArgumentError('Doctor ID does not exist: $doctorId');
        }
      } else {
        throw ArgumentError('Invalid or empty Doctor ID: $doctorId');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve doctor details: $e',
          snackPosition: SnackPosition.BOTTOM);
      rethrow;
    }
  }




 
  // delete appointment
  //************************************************************************** */

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .delete();
      fetchAppointments();
      Get.snackbar('Success', 'Appointment details deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete appointment details',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
