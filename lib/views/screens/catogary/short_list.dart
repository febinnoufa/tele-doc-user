import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/catogary.dart/catogary_controller.dart';
import 'package:teledocuser/views/widgets/appbar/appbar.dart';
import 'package:teledocuser/views/widgets/catogary/list_shoer_vise.dart';

class CategariViseShortScreen extends StatelessWidget {
   CategariViseShortScreen({super.key});
 // final data;

  final CategariController cntrl =Get.put(CategariController());

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(title: cntrl.data!.name),
          ListCatecaryViseWidget()

        ],
      ),
    );

  }
}