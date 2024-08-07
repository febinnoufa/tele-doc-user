import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exception_helper/exception_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teledocuser/views/screens/login/login_screen.dart';
import 'package:teledocuser/model/user/usermodel.dart';
import 'package:teledocuser/views/screens/signup/details_screen.dart';
import 'package:teledocuser/views/widgets/BottomNav/bottomnav_swidget..dart';
import 'package:path/path.dart';

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
  var imageTemporary = "".obs;
  var downloadUrl = "".obs;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    if (auth.currentUser != null) {
      fetchUserData(auth.currentUser!.uid);
    }
  }

// fetch that user data
  //************************************************************************** */

  Future<void> fetchUserData(String uid) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (docSnapshot.exists) {
        currentUser.value = UserModel.fromMap(docSnapshot);
      }
    } catch (e) {
      // print('Error fetching user data: $e');
    }
  }

  // Get Image
  //************************************************************************** */

  Future<void> getImage(image) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    image.value = pickedImage.path;
  }

  // Upload Image Firestore
  //************************************************************************** */

  Future<String?> uploadImage(File image) async {
    try {
      loading.value = true;
      String fileName = basename(image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      loading.value = false;

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  // User SignUp
  //************************************************************************** */

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

  // Set SharedPref
  //************************************************************************** */

  Future<void> _setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  //  Createuser
  //************************************************************************** */

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

  // user Data Store FireStore
  //************************************************************************** */

  adduser() async {
    try {
      UserModel user = UserModel(
        firstname: firstnamecontroller.text,
        lastdname: lastnamecontroller.text,
        email: auth.currentUser!.email,
        place: placecontroller.text,
        profile: downloadUrl.value,
        address: addresscontroller.text,
        age: int.parse(agecontroller.text),
        phonenumber: int.parse(phonecontroller.text),
        password: passwordcontroller.text,
        id: auth.currentUser!.uid,
      );
      await db.collection("users").doc(auth.currentUser?.uid).set(user.toMap());
      Get.offAll(() => const BotomNavigationBar());
    } catch (e) {
      Get.snackbar("Error", "Failed to add user: $e");
    }
  }

  // User SignOut
  //************************************************************************** */

  singout() async {
    await auth.signOut();
    await _setLoginStatus(false);
  }

  // User SignIn
  //************************************************************************** */

  singin() async {
    try {
      await ExceptionHandler.handleExceptions(
        action: () async {
          loading.value = true;
          await auth.signInWithEmailAndPassword(
              email: loginemailcontroller.text,
              password: loginpasswordcontroller.text);
          await _setLoginStatus(true);

          loading.value = false;
          Get.offAll(const BotomNavigationBar());
        },
      );
    } catch (e) {
      Get.snackbar("error", "$e");
      print("$e ................................");
      loading.value = false;
    }
  }

  // Verify Imaail
  //************************************************************************** */

  verifyemail() async {
    await auth.currentUser?.sendEmailVerification();
    Get.snackbar("email", "send");
  }





  // Reset Password
  //************************************************************************** */

  resetpassword() async {
    try {
      await ExceptionHandler.handleExceptions(
        action: () async {
          loading.value = true;
          await auth.sendPasswordResetEmail(email: resetemailcontroller.text);
          Get.snackbar("email", "send successfully");
          Get.to(LoginScreen());
          loading.value = false;
        },
      );
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }






  
  // Login With Google
  //************************************************************************** */


  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn =
          GoogleSignIn(); // Create a new GoogleSignIn instance
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
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



  // Logout Google
  //************************************************************************** */


  Future<void> logoutgoogle() async {
    await auth.signOut();
    await googleSignIn.signOut(); // Sign out from Google Sign-In
    await _setLoginStatus(false);
  }
}
