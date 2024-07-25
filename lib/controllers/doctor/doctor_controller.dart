import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';

class DoctorController extends GetxController {
  var currentdoc;




 // GetDoctor
  //************************************************************************** */

  Stream<List<DoctorModel>> get doctorStream {
    return FirebaseFirestore.instance
        .collection('approveddoctors')
        .snapshots()
        .map((QuerySnapshot query) {
      List<DoctorModel> doctors = [];
      for (var doc in query.docs) {
        doctors.add(DoctorModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return doctors;
    });
  }

 

  
  // Function to search doctors by name
  //************************************************************************** */

  Stream<List<DoctorModel>> searchDoctors(String searchQuery) {
    return FirebaseFirestore.instance
        .collection('approveddoctors')
        .where('doctorName', isEqualTo: searchQuery)
        .snapshots()
        .map((QuerySnapshot query) {
      List<DoctorModel> doctors = [];
      for (var doc in query.docs) {
        doctors.add(DoctorModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return doctors;
    });
  }
}
