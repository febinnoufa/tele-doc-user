import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/views/screens/introscreens/screen2.dart';


class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/undraw_medicine_b1ol (1) 1.png",
              height: 220,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Text(
                  "Striving to improve community health",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                )),
                SizedBox(
                  height: 15,
                ),
                Center(child: Text("care and practices"))
              ],
            ),
            const Center(
                child: Text(
              "IMPROVE YOUR LIFESTYLE",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: const Text("Skip")),
                IconButton(
                  onPressed: () {
                    Get.offAll(const IntroScreenTwo());
                  },
                  icon: const Icon(Icons.arrow_circle_right),
                  iconSize: 40,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
