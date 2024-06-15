import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';
import 'package:teledocuser/views/screens/appoiment/doctor_details.dart';
import 'package:teledocuser/views/screens/chating/chat_screen.dart';

class ChatingShowAllDoctors extends StatelessWidget {
  ChatingShowAllDoctors({super.key});
  final DoctorController doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DoctorModel>>(
      stream: doctorController.doctorStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No doctors found'));
        } else {
          final doctors = snapshot.data!;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return Column(
                children: [
                  const SizedBox(height: 5),
                  ListTile(
                    
                    leading: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 60,
                      height: 70,
                      // ignore: unnecessary_null_comparison
                      child: doctor.profile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                doctor.profile,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                    ),
                    trailing: Text("12:30"),
                    title: Text("Dr ${doctor.name}" ?? 'No Name'),
                    subtitle: Text("Hi"),
                    //  trailing: Text(doctor.lastMessageTime ?? 'No Time'),
                    onTap: () {
                      // Navigate to doctor details or chat screen
                       Get.to(() => ChatScreen(receiverDoctor: doctor));
                    },
                  ),
                  const SizedBox(height: 5),
                  const Divider(thickness: 2),
                ],
              );
            },
          );
        }
      },
    );
  }
}
