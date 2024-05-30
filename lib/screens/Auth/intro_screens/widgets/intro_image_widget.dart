import 'package:flutter/material.dart';

class IntroImageWidget extends StatelessWidget {
 // ignore: prefer_typing_uninitialized_variables
 final  imagepath;
   const IntroImageWidget({super.key,required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagepath,height: 400,);
  }
}