import 'package:flutter/material.dart';
import 'package:teledocuser/views/widgets/appbar/appbar.dart';
import 'package:teledocuser/views/widgets/catogary/list.dart';

class AllCatogaryScreen extends StatelessWidget {
  const AllCatogaryScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          const  AppBarWidget(
              title: "All Categories",
            ),
            CatogariesList()
          ],
        ),
      ),
    );
  }
}
