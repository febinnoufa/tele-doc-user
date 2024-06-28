import 'package:flutter/material.dart';
import 'package:teledocuser/views/widgets/appbar/home_appbar.dart';
import 'package:teledocuser/views/widgets/home/avalbe_doc_widget.dart';
import 'package:teledocuser/views/widgets/home/carousal_widget.dart';
import 'package:teledocuser/views/widgets/home/catigarywidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HomeAppBar(),
            const CarousalHomeWidget(),
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
