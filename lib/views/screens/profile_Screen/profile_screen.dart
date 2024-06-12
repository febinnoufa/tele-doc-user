import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';
import 'package:teledocuser/views/screens/login/login_screen.dart';
import 'package:teledocuser/views/widgets/profile/show_all_details.dart';
import 'package:teledocuser/views/widgets/profile/show_details_widgets.dart';
import 'package:teledocuser/controllers/auth/controller.dart';

class ProfileScreenUser extends StatefulWidget {
  const ProfileScreenUser({super.key});

  @override
  State<ProfileScreenUser> createState() => _ProfileScreenUserState();
}

class _ProfileScreenUserState extends State<ProfileScreenUser> {
  final Authcontroller authController = Get.find<Authcontroller>();
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final currentUser = authController.auth.currentUser;
    if (currentUser != null) {
      await authController.fetchUserData(currentUser.uid);
      setState(() {}); // Force rebuild to show fetched data
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser.value;
    appointmentController.image = user!.profile;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 140, 235, 143),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Center(
            child: Text(
              "Profile",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () => _showAlertDialog(context),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            )
          ],
          elevation: 0,
        ),
        body: Column(
          children: [
            ShowUserDatasPhoto(image: user.profile),
            user != null
                ? ShowAllDetailsUserWidget(
                    user: user,
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('LogOut'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to Logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                authController.singout();
                Get.to(() => LoginScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
