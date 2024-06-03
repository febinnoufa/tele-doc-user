import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/views/screens/appoiment/time_select_screen.dart';


class AppointmentDetailsWidget extends StatelessWidget {
  const AppointmentDetailsWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Appointment For",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15.0),
          _buildTextField("Patient Name", TextInputType.name),
          const SizedBox(height: 15.0),
          _buildTextField("Contact Number", TextInputType.phone),
          const SizedBox(height: 15.0),
          _buildTextField("Reason for Appointment", TextInputType.multiline),
          SizedBox(height: 80,),
  Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius:
                    BorderRadius.circular(8), // Adjust the radius as needed
              ),
              child: TextButton(
                onPressed: () {
                  Get.to(TimeSlotPickerDemo());
                 // Get.to( AppoimentBookingPage());
                  
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

  Widget _buildTextField(String labelText, TextInputType keyboardType) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
