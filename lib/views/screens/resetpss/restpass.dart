import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/Auth/controller.dart';


class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final cntr = Get.put(Authcontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),

          const Center(
            child: Column(
              children: [
                Text(
                  "FORGOT PASSWORD",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Please Enter Your Register Mobile Number",
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "To Receive a Verification Code",
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          // Text("Email"),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              borderRadius: BorderRadius.circular(25),
              elevation: 20,
              child: TextFormField(
                controller: cntr.resetemailcontroller,
                //controller: controller.placecontroller,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    size: 20,
                  ),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Obx(
            () => SizedBox(
              height: 50.0,
              child: SizedBox(
                width: 150.0,
                child: ElevatedButton(
                  onPressed: () {
                    cntr.resetpassword();

                    //   controller.singup();

                    //  Get.off(UserProfileScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        color: Colors.green,
                        width: 3.0, 
                      ),
                    ),
                    minimumSize: const Size(100, 0), 
                  ),
                  child: cntr.loading.value
                      ? CircularProgressIndicator()
                      : Text("Send"),
                  // controller.loading.value ?CircularProgressIndicator(color: Colors.white,): Text("Signup"),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
