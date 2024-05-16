import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 227, 227),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${FirebaseAuth.instance.currentUser!.displayName}"),
        const Center(
          child: Text("hiiiii",),
        ),

        ElevatedButton(onPressed: (){}, child: const Text("logout"))
      ],
    ),
    );
  }
}