import 'package:flutter/material.dart';

import 'package:teledocuser/screens/login_screen/widgets/form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
        ),
        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
             Padding(
              padding: EdgeInsets.all(20),
              child: LoginForms(),
            ),
            const Center(
                child: Text(
              "OR",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              "Log in with",
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
            const SizedBox(height: 10,),
            IconButton(onPressed: (){}, icon: Image.network("https://cdn-teams-slug.flaticon.com/google.jpg",height: 50,),iconSize: 100,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                TextButton(onPressed: (){}, child: const Text("Register now"))
              ],
            )
           

          ],
        ),
      ),
    );
  }
}
