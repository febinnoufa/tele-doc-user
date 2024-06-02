import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/screens/Auth/login_screen/screens/login_screen.dart';
import '../../../../controllers/screens/Auth/profile_Screen/widgets/show_all_details.dart';
import '../../../../controllers/screens/Auth/profile_Screen/widgets/show_details_widgets.dart';
import '../../../../controllers/screens/Auth/singup/controller/controller.dart';

class ProfileScreenUser extends StatefulWidget {
  const ProfileScreenUser({super.key});

  @override
  State<ProfileScreenUser> createState() => _ProfileScreenUserState();
}

class _ProfileScreenUserState extends State<ProfileScreenUser> {
  final Authcontroller authController = Get.find<Authcontroller>();

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
            ShowUserDatasPhoto(),
            user != null
                ? ShowAllDetailsUserWidget(
                    user: user,
                  )
                : const CircularProgressIndicator(), // Show loading indicator while data is being fetched
          ],
        ),
      ),
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
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
