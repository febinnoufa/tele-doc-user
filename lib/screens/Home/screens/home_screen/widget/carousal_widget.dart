import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:teledocuser/const/const.dart';

class CarousalHomeWidget extends StatelessWidget {
  const CarousalHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 210),
          child: Text(
            "Specialist",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: [carolisis(), carolisis(), carolisis()],
        ),
      ],
    );
  }

  Widget carolisis() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: greenColor,
          ),
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 30),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Looking For Your Desire",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Specialist Doctor ?",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Positioned(
            top: 120, // Adjust as needed
            left: 30, // Adjust as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr Salina zaman",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Hearth specialist",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            )),
        const Positioned(
          top: 50, // Adjust as needed
          left: 170, // Adjust as needed
          child: Image(
            image: AssetImage("assets/images-removebg-preview.png"),
            height: 150,
          ),
        ),
      ],
    );
  }
}
