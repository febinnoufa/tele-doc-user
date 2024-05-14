import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/screens/intro_screens/screen1.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const IntroScreenOne()); 
    });

    return  Scaffold(
      backgroundColor:witecolor,
      body: Center(
        child: Image.asset("assets/TELE DOC(1).png")
      ),
    );
  }
}
