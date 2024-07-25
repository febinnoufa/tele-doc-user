import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/views/screens/chating/home_chat.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 16),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Find your",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
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
          const Text(
            "Specialist",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
