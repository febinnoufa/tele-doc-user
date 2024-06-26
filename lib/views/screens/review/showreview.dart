import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teledocuser/controllers/review/reviewcard.dart';


class ShowDoctorreview extends StatelessWidget {
  final String currentDoctorId;

  const ShowDoctorreview({Key? key, required this.currentDoctorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('approveddoctors')
          .doc(currentDoctorId)
          .collection('review')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No reviews found'));
        }

        final reviews = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final reviewData = reviews[index].data() as Map<String, dynamic>;
            return ReviewCard(
              review: reviewData['review'],
              rating: (reviewData['raiting'] as num).toDouble(),
              userName: reviewData['userName'],
              userProfile: reviewData['userProfile'],
            );
          },
        );
      },
    );
  }
}
