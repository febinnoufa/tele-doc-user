import 'package:flutter/material.dart';
import 'package:teledocuser/views/widgets/signup/form.dart';


class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        ),
        body:  ListView(
          children: [
            const SizedBox(height: 40,),
            const Center(child: Text("SIGNUP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            const SizedBox(height: 30,),
             SingUpFormWidget(),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                TextButton(onPressed: (){}, child: const Text("Login"))
              ],
            )

          ],
        ),

    ));
  }
}