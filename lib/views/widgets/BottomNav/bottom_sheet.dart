import 'package:flutter/material.dart';


class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Sheet Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
         
          child: const Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}
