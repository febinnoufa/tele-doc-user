import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/search/search_controller.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';
import 'package:teledocuser/views/widgets/search/doctor_items.dart';

class SearchPage extends StatelessWidget {
  final SearchControllerDoc searchController = Get.put(SearchControllerDoc());

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Here"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: TextField(
                decoration: const InputDecoration(
                  //   border: UnderlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                ),
                onChanged: (val) => searchController.filterByName(val),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('approveddoctors')
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshots.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                return Obx(() {
                  var filteredDocs = snapshots.data!.docs.where((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    return searchController.name.value.isEmpty ||
                        data['name'].toString().toLowerCase().startsWith(
                            searchController.name.value.toLowerCase());
                  }).toList();

                  if (filteredDocs.isEmpty) {
                    return const Center(
                      child: Text('No doctor found with that name'),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      var data =
                          filteredDocs[index].data() as Map<String, dynamic>;
                      DoctorModel doctor = DoctorModel.fromMap(data);

                      return DoctorListItem(doctor: doctor);
                    },
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}


