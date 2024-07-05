import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key,required this.title,required this.backarrow});
 final String title;
 final bool backarrow;

  @override
  Widget build(BuildContext context) {
    return  AppBar(
        leading: 
        backarrow ==true ?
        IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.black,)):SizedBox(),
        title: Text(title,style: const TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      
      );
    
   
  }
}