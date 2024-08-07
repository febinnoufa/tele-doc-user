import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/views/screens/introscreens/screen3.dart';
import 'package:teledocuser/views/screens/login/login_screen.dart';
import 'package:teledocuser/views/widgets/intro/intro_image_widget.dart';
import 'package:teledocuser/views/widgets/intro/intro_text_widget.dart';


class IntroScreenTwo extends StatelessWidget {
  const IntroScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
             
                Column(
                    children: [
                      IntroImageWidget(
                        imagepath: "assets/image(1).png",
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      const IntroTextWidget(text1: "Find Trusted Doctors",text2: "Contrary to popular belief,Lorem Ipsum is not",text3: ' simply random text.It has roots in a piece of it',text4: ' over 2000 years old.'),
                      
                    ],
                  ),
                 Expanded(
                   child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 TextButton(onPressed: (){
                                   Get.offAll(LoginScreen());
                                 }, child: const Text("Skip")),
                                 IconButton(onPressed: (){
                    Get.offAll(const IntroScreenTree());
                                 }, icon: const Icon(Icons.arrow_circle_right),iconSize: 40,)
                               ],
                             ),
                 )
              ],
            )));
  }
}
