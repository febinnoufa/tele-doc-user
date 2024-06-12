import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/model/schedules/shedul.dart';

class TimeselectController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final DoctorController dcCntrl = Get.put(DoctorController());

  List<Schedule> schedules = [];

  Future<void> fetchUserSchedules() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot snapshot = await _db
          .collection("approveddoctors")
          .doc(dcCntrl.currentdoc.id)
          .collection("shedules")
          .orderBy('createdAt', descending: true)
          .get();

      schedules = snapshot.docs.map((doc) => Schedule.fromFirestore(doc)).toList();
      update();
    }
  }
}
