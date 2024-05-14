import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/screens/profile_Screen/profil_Screen.dart';
import 'package:teledocuser/screens/singup/controller/controller.dart';



class DetailsFormWidget extends StatelessWidget {
  DetailsFormWidget({super.key});
  final cntlr = Get.put(Authcontroller());

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
              controller: cntlr.phonecontroller,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  size: 20,
                ),
                hintText: 'Phone Number',
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
              controller: cntlr.placecontroller,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  size: 20,
                ),
                hintText: 'Place',
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
              controller: cntlr.agecontroller,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  size: 20,
                ),
                hintText: 'age',
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
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.account_box_rounded,
                  size: 20,
                ),
                hintText: 'Address',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Obx( ()=>
           SizedBox(
            height: 50.0,
            child: SizedBox(
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {
                  cntlr.singup();
        
                  Get.off(UserProfileScreen());
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
                child: cntlr.loading.value ?CircularProgressIndicator(): Text("Signup"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
