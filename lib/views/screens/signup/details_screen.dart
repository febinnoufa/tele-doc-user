import 'package:flutter/material.dart';
import 'package:teledocuser/views/widgets/signup/details_form.dart';


class SingUpDetailScreen extends StatelessWidget {
  const SingUpDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            "DETAILS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
          const SizedBox(
            height: 30,
          ),
          DetailsFormWidget(),
        ],
      ),
    ));
  }
}
