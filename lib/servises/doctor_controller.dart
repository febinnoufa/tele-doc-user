import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teledocuser/servises/model/doctor_model.dart';

class DoctorController extends GetxController {
  var currentdoc;
  Stream<List<DoctorModel>> get doctorStream {
    return FirebaseFirestore.instance
        .collection('approveddoctors')
        .snapshots()
        .map((QuerySnapshot query) {
      List<DoctorModel> doctors = [];
      query.docs.forEach((doc) {
        doctors.add(DoctorModel.fromMap(doc.data() as Map<String, dynamic>));
      });
      return doctors;
    });
  }
}
