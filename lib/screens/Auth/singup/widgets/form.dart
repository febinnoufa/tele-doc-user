import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/screens/Auth/singup/controller/controller.dart';
import 'package:teledocuser/screens/Auth/singup/screens/details_screen.dart';

class SingUpFormWidget extends StatelessWidget {
  SingUpFormWidget({super.key});
  final Authcontroller cntlr = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Material(
              borderRadius: BorderRadius.circular(25),
              elevation: 20,
              child: TextFormField(
                controller: cntlr.firstnamecontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 20,
                  ),
                  hintText: 'First Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
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
                controller: cntlr.lastnamecontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 20,
                  ),
                  hintText: 'Last Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
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
      controller: cntlr.emailcontroller,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email,
          size: 20,
        ),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        // Email format validation using regex
        bool validEmail = RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          caseSensitive: false,
          multiLine: false,
        ).hasMatch(value);
        if (!validEmail) {
          return 'Please enter a valid email address';
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
                controller: cntlr.passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 20,
                  ),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add password validation logic here if needed
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
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 20,
                  ),
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  // Add password confirmation logic here if needed
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 50.0,
            child: SizedBox(
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    cntlr.singup();
                    Get.offAll(const SingUpDetailScreen());
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
                child: cntlr.loading.value
                    ? const CircularProgressIndicator()
                    : const Text("Signup"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
