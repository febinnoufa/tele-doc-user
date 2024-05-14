import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/screens/login_screen/screens/login_screen.dart';

class IntroScreenFive extends StatelessWidget {
  const IntroScreenFive({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 500,
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 246, 247, 248),
                    Color.fromARGB(255, 169, 219, 171),
                    Color.fromARGB(255, 248, 248, 249)
                  ], // Customize your gradient colors here
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "SKY HEALTH",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: greenColor),
                  ),
                  const Text(
                    "IMPROVE YOUR LIFESTYLE",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        "Striving to improve",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "community health",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "care and practices",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Get.offAll(const LoginScreen());
                    },
                    icon: const Icon(
                      Icons.arrow_circle_right,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            "assets/undraw_medicine_b1ol (1) 1.png",
            height: 250,
          )
        ],
      ),
    ));
  }
}
