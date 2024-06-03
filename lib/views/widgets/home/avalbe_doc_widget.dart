import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/views/screens/appoiment/doctor_details.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';


class AvalbleDoctorsWidget extends StatelessWidget {
  final DoctorController doctorController = Get.put(DoctorController());

  AvalbleDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Available Doctors",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  // Handle "See All" button tap
                },
                child: const Text("See All"),
              ),
            ],
          ),
          StreamBuilder<List<DoctorModel>>(
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
                return SizedBox(
                  height: 190,
                  child: ListView.builder(
                    itemCount: doctors.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return InkWell(
                        onTap: () {
                          doctorController.currentdoc = doctor;

                          Get.to(DoctorDetailsScreen(
                            doctor: doctor,
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: doctorCard(doctor),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget doctorCard(DoctorModel doctor) {
    return Stack(
      children: [
        Container(
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromARGB(255, 231, 228, 228),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
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
                  "Rating",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                   Icon(Icons.star,size: 15,),
                   Icon(Icons.star,size: 15,),
                   Icon(Icons.star,size: 15,),
                   Icon(Icons.star,size: 15,)
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20, // Adjust as needed
          left: 150,
          // /right: 10, // Adjust as needed
          child: Material(
            elevation: 4, // Elevation for the shadow
            borderRadius:
                BorderRadius.circular(8), // Border radius for rounded corners
            child: Container(
              height: 150, // Fixed height
              width: 100, // Fixed width
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(8), // Border radius for the image
                child: Image(
                  image: NetworkImage(doctor.profile),
                  fit: BoxFit
                      .cover, // Adjust how the image is inscribed into the box
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
