import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';

class AllDoctorsWidget extends StatelessWidget {
  AllDoctorsWidget({super.key});

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
          return Expanded(
            child: ListView.builder(
              itemCount: doctors.length,
              // scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return InkWell(
                  onTap: () {
                    doctorController.currentdoc = doctor;

                    // //Get.to(DoctorDetailsScreen(
                    //   doctor: doctor,
                    // ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: doctorCard(doctor),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget doctorCard(DoctorModel doctor) {
    return Stack(
      children: [
        Container(
          //width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromARGB(255, 231, 228, 228),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Dr ${doctor.name}",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Text(
                  doctor.specialist,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Experience",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "${doctor.experience} Year",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Gender",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                 Row(
                  children: [
                    Text(
                  "${doctor.genter} ",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 180,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 150,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: NetworkImage(doctor.profile),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
