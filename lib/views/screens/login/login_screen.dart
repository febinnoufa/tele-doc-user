import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/views/widgets/login/form.dart';
import 'package:teledocuser/controllers/auth/controller.dart';
import 'package:teledocuser/views/screens/signup/singup1_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});
  final cntr = Get.put(Authcontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
        ),
        body: ListView(
         
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: LoginForms(),
            ),
            // const Center(
            //     child: Text(
            //   "OR",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // )),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Center(
            //     child: Text(
            //   "Log in with",
            //   style: TextStyle(fontWeight: FontWeight.w500),
            // )),
            const SizedBox(
              height: 100,
            ),
            // IconButton(
            //   onPressed: () async {
            //     // await cntr.signInWithGoogle();
            //     await cntr.loginWithGoogle();
            //     // /  Get.off(SingUpDetailScreen());
            //     // Get.to(const DummyScreen());
            //   },
            //   icon: Image.network(
            //     "https://cdn-teams-slug.flaticon.com/google.jpg",
            //     height: 50,
            //   ),
            //   iconSize: 100,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                TextButton(
                    onPressed: () {
                      Get.to(const SingUpScreen());
                    },
                    child: const Text("Register now"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
