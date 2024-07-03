import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';
import 'package:teledocuser/views/screens/appoiment/doctor_details.dart';

class DoctorListItem extends StatelessWidget {
  final DoctorModel doctor;

  DoctorListItem({
    super.key,
    required this.doctor,
  });

  final DoctorController doctorcntr = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        doctorcntr.currentdoc = doctor;
        Get.to(DoctorDetailsScreen(doctor: doctor));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(255, 231, 228, 228),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 180, top: 10),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${doctor.experience} ",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Gender",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          doctor.genter,
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
              top: 25,
              left: 30,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 150,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images-removebg-preview.png',
                      image: doctor.profile,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 150,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}