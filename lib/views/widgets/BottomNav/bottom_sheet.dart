import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Sheet Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          //_showBottomSheet(context),
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
    void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        color: Colors.blueGrey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('This is a Persistent Bottom Sheet!'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
