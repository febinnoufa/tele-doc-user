import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/screens/login_screen/screens/login_screen.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("hi"),
            auth.currentUser!.emailVerified
                ? SizedBox(
                    height: 1,
                  )
                : Text("email not verifyd"),
            auth.currentUser!.email == null
                ? const Text("nulll")
                : Text(auth.currentUser!.email.toString()),
            SizedBox(
              height: 200,
            ),
            IconButton(
                onPressed: () async {
                  await auth.signOut();
                  Get.offAll(LoginScreen());
                },
                icon: Icon(Icons.login))
          ],
        ),
      ),
    );
  }
}
