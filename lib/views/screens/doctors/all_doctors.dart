import 'package:flutter/material.dart';
import 'package:teledocuser/views/widgets/appbar/appbar.dart';
import 'package:teledocuser/views/widgets/doctors/all_doc_widget.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            AppBarWidget(title: "All Doctors"),
            AllDoctorsWidget()
            
          ],
        ),
      ),
    );
  }
}