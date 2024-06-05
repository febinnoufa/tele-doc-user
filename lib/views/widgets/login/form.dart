import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/views/screens/resetpss/restpass.dart';
import 'package:teledocuser/controllers/auth/controller.dart';



class LoginForms extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  LoginForms({Key? key});

  final cntr = Get.put(Authcontroller());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "EMAIL",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
          TextFormField(
            controller: cntr.loginemailcontroller,
            decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: const Icon(
                  Icons.email,
                  size: 20,
                )),
          ),
          const SizedBox(height: 30),
          // const Text(
          //   "PASSWORD",
          //   style: TextStyle(fontSize: 12,),
          // ),
          TextFormField(
            controller: cntr.loginpasswordcontroller,
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
              prefixIcon: const Icon(
                Icons.lock,
                size: 20,
              ),
              hintText: 'Enter your password',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.to(ResetPasswordScreen());
              },
              child: const Text("Forgot Password?")),
          const SizedBox(height: 20),
          Obx(
            () => SizedBox(
              height: 50.0,
              child: SizedBox(
                width: 150.0,
                child: ElevatedButton(
                  onPressed: () {
                    cntr.singin();
                    cntr.loginemailcontroller.clear();
                    cntr.loginpasswordcontroller.clear();
                    //Get.off( const SingUpScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        color: Colors.green, // Change border color here
                        width: 3.0, // Change border thickness here
                      ),
                    ),
                    minimumSize: const Size(100, 0), // Set minimum button size
                  ),
                  child: cntr.loading.value
                      ? const CircularProgressIndicator()
                      : const Text("LOGIN"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
