import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';

class DoctorController extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  var currentdoc;
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
}
