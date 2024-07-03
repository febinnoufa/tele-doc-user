import 'package:flutter/material.dart';

class IntroTextWidget extends StatelessWidget {
  final String  text1;
  final String text2;
  final String text3;
  final String text4;
  const IntroTextWidget({super.key,required this.text1,required this.text2,required this.text3,required this.text4});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(text1,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
        const SizedBox(height: 20,),
         Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                 text2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 10,),
                 Text(
                  text3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 10,),
                 Text(
                  text4,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
        ),
      ],
    );
  }
}