import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/auth/controller.dart';


class DetailsFormWidget extends StatelessWidget {
  DetailsFormWidget({super.key});

  final Authcontroller controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
         InkWell(
                    onTap: () {
                      controller
                          .getImage(controller.imageTemporary);
                    },
                    child: Obx(
                      () => CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.black,
                        backgroundImage: controller
                                .imageTemporary.value.isNotEmpty
                            ? FileImage(File(
                                controller.imageTemporary.value))
                            : const AssetImage('assets/profile.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
         const SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Material(
              borderRadius: BorderRadius.circular(25),
              elevation: 20,
              child: TextFormField(
                controller: controller.phonecontroller,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 20,
                  ),
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length != 10) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              borderRadius: BorderRadius.circular(25),
              elevation: 20,
              child: TextFormField(
                controller: controller.placecontroller,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 20,
                  ),
                  hintText: 'Place',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your place';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Material(
              borderRadius: BorderRadius.circular(25),
              elevation: 20,
              child: TextFormField(
                controller: controller.agecontroller,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 20,
                  ),
                  hintText: 'Age',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              borderRadius: BorderRadius.circular(25),
              elevation: 20,
              child: TextFormField(
                controller: controller.addresscontroller,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.account_box_rounded,
                    size: 20,
                  ),
                  hintText: 'Address',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Obx(
            () => SizedBox(
              height: 50.0,
              child: SizedBox(
                width: 150.0,
                child: ElevatedButton(
                  onPressed: ()async {
        if (controller
                              .imageTemporary.value.isNotEmpty) {
                            File imageFile = File(
                                controller.imageTemporary.value);
                            String? imageUrl = await controller
                                .uploadImage(imageFile);

                            if (imageUrl != null) {
                              controller.downloadUrl.value =
                                  imageUrl;
                            //  print('Image uploaded successfully: $imageUrl');
                            } else {
                              print('Failed to upload image');
                              // Handle the error case here if needed
                            }
                          } else {
                            print('No image selected');
                            // Handle the case where no image is selected
                          }


                    if (_formKey.currentState?.validate() ?? false) {
                     await controller.singup();
                     await controller.adduser();
                      controller.firstnamecontroller.clear();
                      controller.lastnamecontroller.clear();
                      controller.emailcontroller.clear();
                      controller.passwordcontroller.clear();
                      controller.agecontroller.clear();
                      controller.placecontroller.clear();
                      controller.addresscontroller.clear();
                      controller.phonecontroller.clear();
                      // Get.off(UserProfileScreen());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        color: Colors.green,
                        width: 3.0,
                      ),
                    ),
                    minimumSize: const Size(100, 0),
                  ),
                  child: controller.loading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Signup"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
