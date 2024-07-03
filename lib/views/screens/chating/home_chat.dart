import 'package:flutter/material.dart';
import 'package:teledocuser/views/widgets/chating/all_doctors.dart';

class ChatingHomeScreen extends StatelessWidget {
  const ChatingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Message",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
    
        ),
        body:  Column(
          children: [

            SizedBox(height: 20,child: Container(color:Colors.white,),),
            SizedBox(height: 10,child: Container(color: const Color.fromARGB(255, 190, 186, 186),),),
             Expanded(child: ChatingShowAllDoctors()),
          ],
        ),
      ),
    );
  }
}
