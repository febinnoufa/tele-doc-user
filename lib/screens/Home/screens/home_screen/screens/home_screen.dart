import 'package:flutter/material.dart';
import '../../../../../../controllers/screens/Home/screens/home_screen/widget/avalbe_doc_widget.dart';
import '../../../../../../controllers/screens/Home/screens/home_screen/widget/carousal_widget.dart';
import '../../../../../../controllers/screens/Home/screens/home_screen/widget/catigarywidget.dart';

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
              onPressed: () {},
              icon: const Icon(
                Icons.message,
                color: Colors.black,
              )),
        ],
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarousalHomeWidget(),
          //SizedBox(height: 10,),
          CategoryHomeWidget(),
           SizedBox(height: 10,),
          AvalbleDoctorsWidget()

        ],
      ),
    ));
  }
}
