import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/catogary.dart/catogary_controller.dart';
import 'package:teledocuser/model/catogary/catogary_model.dart';
import 'package:teledocuser/views/screens/catogary/catogary.dart';
import 'package:teledocuser/views/screens/catogary/short_list.dart';
import 'package:teledocuser/views/widgets/shimmer/shimmer.dart';

class CategoryHomeWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  CategoryHomeWidget({Key? key});
  final CategariController cntr = Get.put(CategariController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, ),
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
                  Get.to(const AllCatogaryScreen());
               
                },
                child: const Text("See All"),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerMyAppointment();
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = CategoryModel.fromMap(
                        documents[index].data() as Map<String, dynamic>);
                    return InkWell(
                      onTap: () {
                        cntr.setSelectedCategory(category);
                        Get.to(CategariViseShortScreen());
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 231, 228, 228),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInImage.assetNetwork(placeholder: 'assets/general.png', image:category.image,height: 50, ),
                            // Image.network(
                            //   category.image,
                            //   height: 50,
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(category.name)
                          ],
                        ),
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

