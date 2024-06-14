import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity, 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), 
        child: Image.network(
          image,
          fit: BoxFit.cover, 
        ),
      ),
    );
  }
}
