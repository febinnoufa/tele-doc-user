import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:teledocuser/const/const.dart';
import 'package:teledocuser/controllers/review/review_rating.dart';

class RatingScreen extends StatelessWidget {
  final RatingController _controller = Get.put(RatingController());

  RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
  //  print('!!!!!!!!!!!!!!!!!!!!!!!!!${_controller.currentDoctorName}');
    return Column(
      children:[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Please rate us',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 20),
            Obx(
              () => RatingBar.builder(
                initialRating: _controller.rating.value,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                onRatingUpdate: (rating) {
                  _controller.updateRating(rating);
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => Text(
                'Your Rating: ${_controller.rating.value}',
                style: const TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _controller.reviewController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Write a review',
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    _controller.submitRatingAndReview();
                    _controller.submitReview();

                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      )
      ]
    );
  }
}
