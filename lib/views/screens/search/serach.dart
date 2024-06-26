import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/controllers/search/search_controller.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';
import 'package:teledocuser/views/screens/appoiment/doctor_details.dart';

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
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
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

                return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    var data =
                        filteredDocs[index].data() as Map<String, dynamic>;
                    DoctorModel doctor = DoctorModel.fromMap(data);

                    return   DoctorListItem(doctor: doctor);
                  },
                );
              });
            },
          )),
        ],
      ),
    );
  }
}

class DoctorListItem extends StatelessWidget {
  final DoctorModel doctor;

  DoctorListItem({
    super.key,
    required this.doctor,
  });

  final DoctorController doctorcntr = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        doctorcntr.currentdoc = doctor;

        Get.to(DoctorDetailsScreen(doctor: doctor));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              // width: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(255, 231, 228, 228),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Dr ${doctor.name}",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      doctor.specialist,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Experience",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${doctor.experience} Year",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Rating",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                     Row(
                      children: [
                        Text(
                      doctor.genter,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20, // Adjust as needed
              left: 180,
              // right: 10, // Adjust as needed
              child: Material(
                elevation: 4, // Elevation for the shadow
                borderRadius: BorderRadius.circular(
                    8), // Border radius for rounded corners
                child: SizedBox(
                  height: 150, // Fixed height
                  width: 100, // Fixed width
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8), // Border radius for the image
                    child: Image(
                      image: NetworkImage(doctor.profile),
                      fit: BoxFit
                          .cover, // Adjust how the image is inscribed into the box
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
