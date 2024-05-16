import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:teledocuser/screens/singup/controller/controller.dart';
import 'package:teledocuser/screens/singup/screens/details_screen.dart';


class SingUpFormWidget extends StatelessWidget {
  SingUpFormWidget({super.key});
  final Authcontroller cntlr = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Material(
            borderRadius: BorderRadius.circular(25),
            elevation: 20,
            child: TextFormField(
              controller: cntlr.firstnamecontroller,
             // obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  size: 20,
                ),
                hintText: 'First Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
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
            //  obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  size: 20,
                ),
                hintText: 'Last Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
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
            //  obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email,
                  size: 20,
                ),
                hintText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
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
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 20,
                ),
                hintText: 'Confirm Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
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
               cntlr.singup();
              Get.offAll(const SingUpDetailScreen());
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: const BorderSide(
                    color: Colors.green, // Change border color here
                    width: 3.0, // Change border thickness here
                  ),
                ),
                minimumSize: const Size(100, 0), // Set minimum button size
              ),
              child: cntlr.loading.value ?const CircularProgressIndicator(): const Text("Signup"),
            ),
          ),
        ),
      ],
    );
  }
}
