import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String review;
  final double rating;
  final String userName;
  final String userProfile;

  const ReviewCard({
    Key? key,
    required this.review,
    required this.rating,
    required this.userName,
    required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userProfile),
              ),
              title: Text(userName),
              subtitle: Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 16,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(review),
          ],
        ),
      ),
    );
  }
}
