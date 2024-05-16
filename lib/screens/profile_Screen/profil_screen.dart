import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/screens/login_screen/screens/login_screen.dart';
import 'package:teledocuser/screens/singup/controller/controller.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final Authcontroller authController = Get.find<Authcontroller>();

  @override
  void initState() {
    super.initState();
    authController.fetchUserData(authController.auth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Obx(() {
          final user = authController.currentUser.value;
          return user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          authController.singout();
                          Get.to(LoginScreen());
                        },
                        child: const Icon(Icons.login)),
                    Text('Name: ${user.firstname} ${user.lastdname}'),
                    Text("age : ${user.age}"),
                    Text("age : ${user.phonenumber}"),
                    Text('Email: ${user.email}'),
                    // Add more fields as needed
                  ],
                )
              : const CircularProgressIndicator();
        }),
      ),
    );
  }
}
