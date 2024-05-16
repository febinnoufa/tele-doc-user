

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teledocuser/screens/login_screen/screens/login_screen.dart';
import 'package:teledocuser/screens/profile_Screen/profil_screen.dart';
import 'package:teledocuser/screens/singup/model/usermodel.dart';
import 'package:teledocuser/screens/singup/screens/details_screen.dart';

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






  Future<void> fetchUserData(String uid) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
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
      // await auth.createUserWithEmailAndPassword(
      //     email: emailcontroller.text, password: passwordcontroller.text);

      //  await adduser();
      // Get.to(()=> UserProfileScreen());
      Get.off(const SingUpDetailScreen());
      await verifyemail();
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e", duration: const Duration(seconds: 4));
      loading.value = false;
    }
  }

  void createUserWithEmailAndPassword(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty.');
      }
      // Call Firebase createUserWithEmailAndPassword method here
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User created successfully, proceed with your logic
    } catch (e) {
      print('Error creating user: $e');
      // Handle and display error to the user
      // You can use Get.snackbar or other methods for showing errors
    }
  }

  adduser() async {
    UserModel user = UserModel(
        firstname: firstnamecontroller.text,
        lastdname: lastnamecontroller.text,
        email: auth.currentUser?.email,
        place: placecontroller.text,
        address: addresscontroller.text,
        age: int.parse(agecontroller.text),
        phonenumber: int.parse(phonecontroller.text),
        password: passwordcontroller.text);
    await db
        .collection("users")
        .doc(auth.currentUser?.uid)
        // .collection("profile")
        .set(user.toMap());

    Get.to(() => UserProfileScreen());
  }

  singout() async {
    await auth.signOut();
  }

  singin() async {
    try {
      loading.value = true;
      await auth.signInWithEmailAndPassword(
          email: loginemailcontroller.text,
          password: loginpasswordcontroller.text);
      Get.to(UserProfileScreen());
      loading.value = false;
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
      Get.snackbar("email", "send seccesfully");
      Get.to(LoginScreen());
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }


  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await googleauth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException (if needed)
      print('FirebaseAuthException: ${e.message}');
    } on PlatformException catch (e) {
      // Handle PlatformException to get more specific error details
      print('PlatformException: ${e.code} - ${e.message}');
      // Example: PlatformException: sign_in_failed - com.google.android.gms.common.api.ApiException: 10:
    } catch (e) {
      // Catch any other unexpected errors
      print('Error signing in with Google: $e');
    }
  }

  // loginWithGoogle() async {
  //   try {

  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();

  //     if (googleSignInAccount != null) {

  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //       await googleauth.signInWithCredential(credential);
  //     }

  //     // final authResult = await     auth.signInWithCredential(credential);

  //     // final User? user = authResult.user;
  //     // assert(!user!.isAnonymous);
  //     // assert(await user!.getIdToken() != null);
  //     // final User? currentUser = auth.currentUser;
  //     // assert(user!.uid == currentUser!.uid);
  //     // Get.toNamed('/homeView'); // navigate to your wanted page
  //     // return;
  //   } on FirebaseAuthException catch (e) {
  //     throw (e);
  //   }
  // }

  logoutgoogle() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }



 
}
