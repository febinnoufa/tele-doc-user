import 'package:flutter/material.dart';

class IntroImageWidget extends StatelessWidget {
 final  imagepath;
   IntroImageWidget({super.key,required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagepath,height: 400,);
  }
}