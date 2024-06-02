import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teledocuser/screens/Auth/intro_screens/screen1.dart';
import 'package:teledocuser/screens/Home/widgets/bottomnav_swidget..dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        Get.off(() => const BotomNavigationBar());
      } else {
        Get.off(() => const IntroScreenOne());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/TELE DOC(1).png"),
      ),
    );
  }
}
