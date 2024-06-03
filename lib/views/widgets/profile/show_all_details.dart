import 'package:flutter/material.dart';

class ShowAllDetailsUserWidget extends StatelessWidget {
  const ShowAllDetailsUserWidget({Key? key,required this.user}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("Name"),
          ),
        ),
        const SizedBox(height: 10),
        _buildContainerWithBorderAndRadius(user.firstname),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("Email"),
          ),
        ),
        const SizedBox(height: 10),
        _buildContainerWithBorderAndRadius(user.email),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("Mobile Number "),
          ),
        ),
        const SizedBox(height: 10),
        _buildContainerWithBorderAndRadius(user.phonenumber),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("Age"),
          ),
        ),
        const SizedBox(height: 10),
        _buildContainerWithBorderAndRadius(user.age),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("Address"),
          ),
        ),
        const SizedBox(height: 10),
        _buildContainerWithBorderAndRadius(user.address),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildContainerWithBorderAndRadius(value) {
    return Container(
      width: 310,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 254, 254),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.only(left: 15, top: 15),
        child: Text("$value"),
      ),
    );
  }
}
