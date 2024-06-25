import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/review/review_rating.dart';

class RatingScreen extends StatelessWidget {
  final RatingController _controller = Get.put(RatingController());

  RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('!!!!!!!!!!!!!!!!!!!!!!!!!${_controller.currentDoctorName}');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Rate Us'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text(
              'Please rate us ${_controller.currentDoctorName}',
              style: TextStyle(fontSize: 23),
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
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
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
            ElevatedButton(
              onPressed: () {
                _controller.submitReview();
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
