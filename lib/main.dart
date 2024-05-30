import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/firebase_options.dart';
import 'package:teledocuser/screens/Auth/singup/controller/controller.dart';
import 'package:teledocuser/screens/splash_screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
   initialBinding: BindingsBuilder(() {
        Get.put(Authcontroller());
      }),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const SplashPage());
  }
}
