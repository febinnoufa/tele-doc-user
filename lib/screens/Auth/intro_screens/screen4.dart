import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/screens/Auth/intro_screens/screen5.dart';
import 'package:teledocuser/screens/Auth/intro_screens/widgets/intro_image_widget.dart';
import 'package:teledocuser/screens/Auth/intro_screens/widgets/intro_text_widget.dart';

class IntroScreenFour extends StatelessWidget {
  const IntroScreenFour({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        Column(
          children: [
            IntroImageWidget(
              imagepath: "assets/image(3).png",
            ),
            const SizedBox(
              height: 70,
            ),
            const IntroTextWidget(
                text1: "Easy Appointments",
                text2: "Contrary to popular belief, Lorem Ipsum is not ",
                text3: 'simply random text. It has roots in a piece of it ',
                text4: 'over 2000 years old.'),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: () {}, child: const Text("Skip")),
              IconButton(
                onPressed: () {
                  Get.offAll(const IntroScreenFive());
                },
                icon: const Icon(Icons.arrow_circle_right),
                iconSize: 40,
              )
            ],
          ),
        )
      ],
    )));
  }
}