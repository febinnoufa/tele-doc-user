import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/views/screens/chating/chat_screen.dart';
import 'package:teledocuser/views/widgets/appoiment/details_doctor.dart';
import 'package:teledocuser/views/widgets/appoiment/image_doctor.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';


class DoctorDetailsScreen extends StatelessWidget {
   DoctorDetailsScreen({super.key,required this.doctor});
  final DoctorModel doctor;
   final DoctorController doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Dr ${doctor.name}",style: const TextStyle(color: Colors.black),),
        centerTitle: true,
        foregroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            doctorController.currentdoc=doctor;
                            Get.to(() => ChatScreen(receiverDoctor: doctor));
          }, icon: Icon(Icons.chat))
        ],


      ),
      body:  Column(
   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoctorImage(image: doctor.profile,),
         const SizedBox(height: 20,),
          Expanded(child: DetailsDoctorWidget(doctor: doctor,))
        ],
      ),
    ));
  }
}
