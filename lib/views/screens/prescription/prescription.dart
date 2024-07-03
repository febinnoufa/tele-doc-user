import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teledocuser/views/screens/review/review.dart';

class SHowAllDataInPrescription extends StatelessWidget {
  final String id;
  const SHowAllDataInPrescription({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Prescription'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('appointments')
            .doc(id)
            .collection('prescription')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }

          final data = snapshot.data;

          if (data == null || data.docs.isEmpty) {
            return const Center(child: Text('No prescriptions found'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    final doc = data.docs[index];
                    final prescriptions = doc['prescriptions'] as List<dynamic>;
                    final docNote = doc['docnote'] ?? '';
                //    final userId = doc['userId'] ?? '';
                    final name = doc['name'] ?? '';
                 //   final timestamp = doc['timestamp']?.toDate() ?? DateTime.now();
          
                    return Column(
                      children: [
                        const SizedBox(height: 40,),
                        Card(
                            elevation: 15,
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Center(
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    
                                  ),
                                  const SizedBox(height: 20,),
                                  const Divider(
                                    thickness: 3,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Doctor Note : ",
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w400),
                                    maxLines: 4,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    docNote,
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w400),
                                    maxLines: 4,
                                  ),
                                  const Divider(
                                    thickness: 3,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ...prescriptions.map((prescription) {
                                    final medName = prescription['medication'] ?? '';
                                    final dosage = prescription['dosage'] ?? 0;
                                    final duration = prescription['duration'] ?? 0;
                                    final durationUnit =
                                        prescription['durationUnit'] ?? '';
                                    final repeat = prescription['repeat'] ?? '';
                                    final timeOfDay = prescription['timeOfDay'] ?? '';
                        
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 5,top: 10),
                                     child: Column(children: [
                                      Row(
                                        children: [
                                          Text("medication  : $medName")
                                        ],
                                      ),
                                     const SizedBox(height: 10,),
                                       Row(
                                        children: [
                                          Text("Dosage  : $dosage Tablet(s)")
                                        ],
                                      ),
                                        const SizedBox(height: 10,),
                                       Row(
                                        children: [
                                          Text("Duration  : $duration $durationUnit"),
                        
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                        Row(
                                        children: [
                                          Text("Repeat  : $repeat "),
                                          
                                        ],
                                      ),
                                          const SizedBox(height: 10,),
                                        Row(
                                        children: [
                                          Text("TimeOfDay  : $timeOfDay "),
                                          
                                        ],
                                      ),
                                      const SizedBox(height: 20,),
                                       const Divider(thickness: 3,)
                                     ],),
                                    );
                                  }).toList(),
                                 
                                ],
                                
                              ),
                            )),
                      ],
                    );
                  },
                ),

                RatingScreen()
              ],
            ),

          );
        },
      ),
    );
  }
}
