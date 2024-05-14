import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/screens/login_screen/screens/login_screen.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key); // Added the Key parameter

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? currentUser = auth.currentUser; // Check if currentUser is not null
    bool isEmailVerified = currentUser?.emailVerified ?? false;
    String userEmail = currentUser?.email ?? '';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hi"),
            if (currentUser != null && !isEmailVerified)
              Text("$userEmail - Email not verified"),
            const SizedBox(height: 100),
            Text(userEmail),
            Text(isEmailVerified ? "Email verified" : "Email not verified"),
            IconButton(
              onPressed: () async {
                await auth.signOut();
                Get.offAll(const LoginScreen());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
