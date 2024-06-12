import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/auth/controller.dart';
import 'package:teledocuser/views/widgets/BottomNav/bottomnav_swidget..dart';

class ShowUserDatasPhoto extends StatelessWidget {
  ShowUserDatasPhoto({super.key, required this.image});
  // ignore: prefer_typing_uninitialized_variables
  final image;
  final Authcontroller authController = Get.find<Authcontroller>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 170,
            color: const Color.fromARGB(255, 254, 255, 254),
          ),
          Positioned(
            top: 00,
            //left: 50,
            child: Container(
              width: 700,
              height: 100,
              color: const Color.fromARGB(255, 140, 235, 143),
            ),
          ),
          Positioned(
            // bottom: 50,
            top: 30,
            //  right: 50,
            child: InkWell(
                onTap: () {
                  Get.to(const BotomNavigationBar());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 189, 197, 189),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 100,
                  height: 120,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20), // Set the radius here
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
