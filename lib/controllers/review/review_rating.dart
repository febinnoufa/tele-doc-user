import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:teledocuser/controllers/review/reviewcard.dart';
import 'package:teledocuser/model/user/usermodel.dart';

class RatingController extends GetxController {
  var rating = 3.0.obs;
  TextEditingController reviewController = TextEditingController();
  var currentDoctorId = ''.obs;
  var currentDoctorName;
  var currentDoctorImage;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      fetchUserData(FirebaseAuth.instance.currentUser!.uid);
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

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }

  void updateRating(double newRating) {
    rating.value = newRating;
  }

  void submitReview() {
    Get.defaultDialog(
      title: 'Thank You!',
      content: Text(
          'You rated ${rating.value} stars.\nReview: ${reviewController.text}'),
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('OK'),
      ),
    );
  }

  submitRatingAndReview() async {
    FirebaseFirestore.instance
        .collection('approveddoctors')
        .doc(currentDoctorId.value)
        .collection('review')
        .doc()
        .set({
      'review': reviewController.text.trim(),
      'raiting': rating.value,
      'userName': currentUser.value!.firstname,
      'userProfile': currentUser.value!.profile,
      'userid': currentUser.value!.id,
    });

    reviewController.text = '';
    rating.value = 3.0;
  }


  fetchreviews(currentDoctorId)async{
    StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
            .collection('approveddoctors')
            .doc(currentDoctorId)
            .collection('review')
            .snapshots(),
          builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No reviews found'));
          }
              final reviews = snapshot.data!.docs;

                return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final reviewData = reviews[index].data() as Map<String, dynamic>;
              return ReviewCard(
                review: reviewData['review'],
                rating: reviewData['raiting'],
                userName: reviewData['userName'],
                userProfile: reviewData['userProfile'],
              );
            },
          );
          },

    );
  }
  // void showRatingDialog() {
  //   Get.defaultDialog(
  //     title: 'Rate Us',
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         const Text('Please rate us:'),
  //         const SizedBox(height: 20),
  //         RatingBar.builder(
  //           initialRating: rating.value,
  //           minRating: 1,
  //           direction: Axis.horizontal,
  //           allowHalfRating: true,
  //           itemCount: 5,
  //           itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
  //           itemBuilder: (context, _) => const Icon(
  //             Icons.star,
  //             color: Colors.amber,
  //           ),
  //           onRatingUpdate: (newRating) {
  //             updateRating(newRating);
  //           },
  //         ),
  //       ],
  //     ),
  //     confirm: TextButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       child: const Text('OK'),
  //     ),
  //   );
  // }
}
