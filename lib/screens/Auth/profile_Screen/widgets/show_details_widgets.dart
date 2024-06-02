import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/screens/Auth/singup/controller/controller.dart';
import '../../../../../controllers/screens/Home/widgets/bottomnav_swidget..dart';

class ShowUserDatasPhoto extends StatelessWidget {
   ShowUserDatasPhoto({super.key});

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
                  color:  const Color.fromARGB(255, 140, 235, 143),
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
                    width: 100,
                    height: 120,
                    color: const Color.fromARGB(255, 189, 197, 189),
                  ),
                ),
              ),
            ],
          ),
        );
      
  }
}