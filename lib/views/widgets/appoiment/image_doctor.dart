import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Fixed height
      width: double.infinity, // Fixed width
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Border radius for rounded corners
        child: Image.network(
          image,
          fit: BoxFit.cover, // Adjust how the image is inscribed into the box
        ),
      ),
    );
  }
}
