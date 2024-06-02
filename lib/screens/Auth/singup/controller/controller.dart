import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../controllers/screens/Auth/login_screen/screens/login_screen.dart';
import '../../../../../controllers/screens/Auth/singup/model/usermodel.dart';
import '../../../../../controllers/screens/Auth/singup/screens/details_screen.dart';
import '../../../../../controllers/screens/Home/widgets/bottomnav_swidget..dart';

class Authcontroller extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController loginemailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController loginpasswordcontroller = TextEditingController();
  TextEditingController resetemailcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final googleauth = FirebaseAuth.instance;
  var loading = false.obs;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    if (auth.currentUser != null) {
      fetchUserData(auth.currentUser!.uid);
    }
  }

  Future<void> fetchUserData(String uid) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (docSnapshot.exists) {
        currentUser.value = UserModel.fromMap(docSnapshot);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  singup() async {
    try {
      loading.value = true;
      createUserWithEmailAndPassword(
          emailcontroller.text, passwordcontroller.text);
      Get.off(const SingUpDetailScreen());
      await verifyemail();
      await _setLoginStatus(true);
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e", duration: const Duration(seconds: 4));
      loading.value = false;
    }
  }

  Future<void> _setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  void createUserWithEmailAndPassword(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty.');
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  adduser() async {
    try {
      UserModel user = UserModel(
        firstname: firstnamecontroller.text,
        lastdname: lastnamecontroller.text,
        email: auth.currentUser?.email,
        place: placecontroller.text,
        address: addresscontroller.text,
        age: int.parse(agecontroller.text),
        phonenumber: int.parse(phonecontroller.text),
        password: passwordcontroller.text,
      );
      await db.collection("users").doc(auth.currentUser?.uid).set(user.toMap());
      Get.to(() => const BotomNavigationBar());
    } catch (e) {
      Get.snackbar("Error", "Failed to add user: $e");
    }
  }

  singout() async {
    await auth.signOut();
    await _setLoginStatus(false);
  }

  singin() async {
    try {
      loading.value = true;
      await auth.signInWithEmailAndPassword(
          email: loginemailcontroller.text,
          password: loginpasswordcontroller.text);
      await _setLoginStatus(true);

      loading.value = false;
      Get.to(const BotomNavigationBar());
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }

  verifyemail() async {
    await auth.currentUser?.sendEmailVerification();
    Get.snackbar("email", "send");
  }

  resetpassword() async {
    try {
      loading.value = true;
      await auth.sendPasswordResetEmail(email: resetemailcontroller.text);
      Get.snackbar("email", "send successfully");
      Get.to(LoginScreen());
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn(); // Create a new GoogleSignIn instance
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);
      await _setLoginStatus(true);
      Get.off(const SingUpDetailScreen());
    }
  } catch (e) {
    print('Error signing in with Google: $e');
  }
}

//   Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential =  GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
 

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }

 Future<void> logoutgoogle() async {
  await auth.signOut();
  await googleSignIn.signOut(); // Sign out from Google Sign-In
  await _setLoginStatus(false);
}
}
