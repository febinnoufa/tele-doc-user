import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/screens/singup/model/usermodel.dart';

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
  var loading = false.obs;
  
 

  singup() async {
    try {
      loading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
      await adduser();
      verifyemail();
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }

  adduser() async {
    //UserCredential userData = await FirebaseAuth.instance;
    UserModel user = UserModel(
      firstname: firstnamecontroller.text,
      secondname: lastnamecontroller.text,
      email: auth.currentUser?.email,
      place: placecontroller.text,
      age: int.tryParse(agecontroller.text),
      password: passwordcontroller.text,
      phonenumber: int.parse(phonecontroller.text),


    );
    await db
        .collection("users")
        .doc()
        .collection("profile")
        .add(user.toMap());
  }

  singout() async {
    await auth.signOut();
  }


  singin()async{
   try {
     await auth.signInWithEmailAndPassword(email: loginemailcontroller.text, password: loginpasswordcontroller.text);
     
   } catch (e) {
     Get.snackbar("error", "$e");
   }
  }


  verifyemail() async{
    await auth.currentUser?.sendEmailVerification();
    Get.snackbar("email", "send");

  }
}
