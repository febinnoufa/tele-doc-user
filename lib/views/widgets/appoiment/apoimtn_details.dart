import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';
import 'package:teledocuser/views/screens/appoiment/time_select_.dart';

class AppointmentDetailsWidget extends StatelessWidget {
  final AppointmentController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  AppointmentDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Appointment For",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15.0),
            _buildTextField(
                "Patient Name", TextInputType.name, controller.nameController,
                (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter patient name';
              }
              return null;
            }),
            const SizedBox(height: 15.0),
            _buildTextField("Contact Number", TextInputType.phone,
                controller.contactController, (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter contact number';
              }
              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return 'Please enter a valid 10-digit contact number';
              }
              return null;
            }),
            const SizedBox(height: 15.0),
            _buildTextField("Reason for Appointment", TextInputType.multiline,
                controller.reasonController, (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the reason for appointment';
              }
              return null;
            }, maxLines: null, textInputAction: TextInputAction.newline),
            const SizedBox(height: 80),
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
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                   
                      Get.to(() => DoctorScheduleScreen());
                    }
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
      ),
    );
  }

  Widget _buildTextField(String labelText, TextInputType keyboardType,
      TextEditingController controller, String? Function(String?)? validator,
      {int? maxLines, TextInputAction? textInputAction}) {
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
      validator: validator,
      maxLines: maxLines,
      textInputAction: textInputAction,
    );
  }
}
