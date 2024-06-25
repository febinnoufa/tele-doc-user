
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RatingController extends GetxController {
  var rating = 3.0.obs;
  TextEditingController reviewController = TextEditingController();
  var currentDoctorId;
  var currentDoctorName;
  var currentDoctorImage;

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
      content: Text('You rated ${rating.value} stars.\nReview: ${reviewController.text}'),
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('OK'),
      ),
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
