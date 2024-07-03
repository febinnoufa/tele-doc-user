import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teledocuser/views/widgets/myappointment/past_widget.dart';
import 'package:teledocuser/views/widgets/shimmer/shimmer.dart';

class PastAppointments extends StatefulWidget {
  const PastAppointments({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<PastAppointments> {
  late Future<List<QueryDocumentSnapshot>> futureAppointments;

  @override
  void initState() {
    super.initState();
    futureAppointments = getAppointmentsForCurrentUser();
  }

  Future<List<QueryDocumentSnapshot>> getAppointmentsForCurrentUser() async {
    try {
      CollectionReference appointments = FirebaseFirestore.instance.collection('appointments');
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot querySnapshot = await appointments
          .where('user', isEqualTo: currentUserId)
          .where('end', isEqualTo: true)
          .get();

      return querySnapshot.docs;
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve appointment details', snackPosition: SnackPosition.BOTTOM);
      return [];
    }
  }

  Future<DocumentSnapshot> getDoctorDetails(String doctorId) async {
    try {
      if (doctorId.isNotEmpty) {
        CollectionReference doctors = FirebaseFirestore.instance.collection('approveddoctors');
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
      Get.snackbar('Error', 'Failed to retrieve doctor details: $e', snackPosition: SnackPosition.BOTTOM);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: futureAppointments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerMyAppointment();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No appointments found.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var appointment = snapshot.data![index].data() as Map<String, dynamic>;
              String doctorId = appointment['docter'] ?? '';

              return FutureBuilder<DocumentSnapshot>(
                future: getDoctorDetails(doctorId),
                builder: (context, doctorSnapshot) {
                  if (doctorSnapshot.connectionState == ConnectionState.waiting) {
                    return const ShimmerMyAppointment();
                  } else if (doctorSnapshot.hasError) {
                    return Center(child: Text('Error: ${doctorSnapshot.error}'));
                  } else if (!doctorSnapshot.hasData || !doctorSnapshot.data!.exists) {
                    return const Center(child: Text('Doctor details not found.'));
                  } else {
                    var doctor = doctorSnapshot.data!.data() as Map<String, dynamic>;
                    String doctorName = doctor['name'] ?? 'Unknown Doctor';
                    String specialty = doctor['specialist'] ?? 'Unknown Specialty';
                    DateTime appointmentDateTime = DateTime.parse('${appointment['date']} ${appointment['time']}');

                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: AppointmentCardPast(
                        doctorId: doctorId,
                        doctorName: doctorName,
                        specialty: specialty,
                        appointment: appointment,
                        appointmentDateTime: appointmentDateTime,
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }
  
}
