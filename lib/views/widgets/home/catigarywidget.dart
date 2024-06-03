import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryHomeWidget extends StatelessWidget {
  CategoryHomeWidget({Key? key});

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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = Category.fromMap(documents[index].data() as Map<String, dynamic>);
                    return Container(
                      width: 100, // Set width for each category item
                      margin: const EdgeInsets.only(
                          right: 10), // Add some spacing between items
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Set border radius
                        // border: Border.all(
                        //   color: Colors.black, // Set border color here
                        //   width: 2, // Set border width here
                        // ),
                        color: Color.fromARGB(255, 231, 228, 228),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(category.image,height: 50,), // Display category image
                          SizedBox(
                            height: 5,
                          ),
                          Text(category.name)
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
