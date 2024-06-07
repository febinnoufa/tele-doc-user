import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';
import 'package:teledocuser/views/screens/appoiment/test.dart';
import 'package:teledocuser/views/screens/appoiment/time_select_screen.dart';
import 'package:teledocuser/views/screens/payment/payment.dart';


class AppointmentDetailsWidget extends StatelessWidget {
  final AppointmentController controller = Get.put(AppointmentController());

  AppointmentDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Appointment For",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15.0),
          _buildTextField("Patient Name", TextInputType.name, controller.nameController),
          const SizedBox(height: 15.0),
          _buildTextField("Contact Number", TextInputType.phone, controller.contactController),
          const SizedBox(height: 15.0),
          _buildTextField("Reason for Appointment", TextInputType.multiline, controller.reasonController),
          const SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
              ),
              child: TextButton(
                onPressed: () async {
                  // await controller.storeAppointmentDetails();
                  // controller.contactController.clear();
                  // controller.nameController.clear();
                  // controller.contactController.clear();
                 // Get.to(() =>  TimeSlotPickerDemo());
                  Get.to(() =>  DoctorScheduleScreen());
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, TextInputType keyboardType, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
