import 'package:flutter/material.dart';
import 'package:teledocuser/screens/appoiment/widgets/details_doctor.dart';
import 'package:teledocuser/screens/appoiment/widgets/image_doctor.dart';
import 'package:teledocuser/servises/model/doctor_model.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key,required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Dr ${doctor.name}",style: const TextStyle(color: Colors.black),),
        centerTitle: true,


      ),
      body:  Column(
   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoctorImage(image: doctor.profile,),
          SizedBox(height: 20,),
          Expanded(child: DetailsDoctorWidget(doctor: doctor,))
        ],
      ),
    ));
  }
}
