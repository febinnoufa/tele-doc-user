import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/views/screens/chating/home_chat.dart';
import 'package:teledocuser/views/widgets/home/avalbe_doc_widget.dart';
import 'package:teledocuser/views/widgets/home/carousal_widget.dart';
import 'package:teledocuser/views/widgets/home/catigarywidget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Find your",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Get.to(const ChatingHomeScreen());
              },
              icon: const Icon(
                Icons.message,
                color: Colors.black,
              )),
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          const  CarousalHomeWidget(),
            //SizedBox(height: 10,),
            CategoryHomeWidget(),
            // const SizedBox(height: 10,),
            AvalbleDoctorsWidget()
      
          ],
        ),
      ),
    ));
  }
}
