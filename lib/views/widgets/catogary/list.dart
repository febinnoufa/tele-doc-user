import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/catogary.dart/catogary_controller.dart';
import 'package:teledocuser/views/screens/catogary/short_list.dart';
import 'package:teledocuser/views/widgets/home/catigarywidget.dart';

class CatogariesList extends StatelessWidget {
  CatogariesList({Key? key});

  final CategariController cntrl = Get.put(CategariController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        print(".............${documents.length}");

        return Expanded(
          child: ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final category = CategoryModel.fromMap(
                  documents[index].data() as Map<String, dynamic>);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 80,
                    child: Center(
                      child: ListTile(
                        onTap: () {
                          cntrl.setSelectedCategory(category);
                          Get.to(CategariViseShortScreen());
                        },
                        leading: SizedBox(
                          height: 100,
                          width: 70,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/general.png',
                            image: category.image,
                            height: 50,
                          ),
                        ),
                        title: Text(category.name),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
