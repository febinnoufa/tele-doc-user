import 'package:flutter/material.dart';

class CategoryHomeWidget extends StatelessWidget {
   CategoryHomeWidget({Key? key});

  List<String> catogaries=[
    "pediatrician",
    "Neurosurgeon",
    "Cardiologist",
    "Psychiatrist"

  ];

  List<String>images=[
    "assets/Pediatrician.png",
    "assets/Neurosurgeon.png",
    "assets/Cardiologist.png",
    "assets/Psychiatrist.png"


  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  // Handle "See All" button tap
                },
                child: const Text("See All"),
              ),
            ],
          ),
         SizedBox(
  height: 100,
  child: ListView.builder(
  itemCount: 4,
  scrollDirection: Axis.horizontal,
  itemBuilder: (context, index) {
    return Container(
      width: 100, // Set width for each category item
      margin: const EdgeInsets.only(right: 10), // Add some spacing between items
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Set border radius
        // border: Border.all(
        //   color: Colors.black, // Set border color here
        //   width: 2, // Set border width here
        // ),
        color: Color.fromARGB(255, 231, 228, 228),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(images[index]),
          SizedBox(height: 5,),
          Text(catogaries[index])
        ],
      ),
    );
  },
),

),

        ],
      ),
    );
  }
}
