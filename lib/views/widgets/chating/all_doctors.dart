import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/chating/chating_controller.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';
import 'package:teledocuser/views/screens/chating/chat_screen.dart';
import 'package:teledocuser/views/widgets/shimmer/shimmer.dart';

class ChatingShowAllDoctors extends StatelessWidget {
  ChatingShowAllDoctors({Key? key}) : super(key: key);

  final DoctorController doctorController = Get.put(DoctorController());
  final ChatingController chatingController = Get.put(ChatingController());

  Stream<List<DoctorModel>> streamDoctorsWithMessages() async* {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    List<Map<String, dynamic>> doctorsWithMessages = [];

    var doctorsSnapshot =
        await FirebaseFirestore.instance.collection('approveddoctors').get();
    for (var doc in doctorsSnapshot.docs) {
      DoctorModel doctor = DoctorModel.fromMap(doc.data());
      String otherUserId = doctor.id.toString();

      List<String> ids = [currentUserId, otherUserId];
      ids.sort();
      String chatRoomId = ids.join("_");

      var messagesSnapshot = await FirebaseFirestore.instance
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .orderBy("timestamp", descending: true)
          .limit(1)
          .get();

      if (messagesSnapshot.docs.isNotEmpty) {
        var lastMessage = messagesSnapshot.docs.first.data();
        doctorsWithMessages
            .add({'doctor': doctor, 'timestamp': lastMessage['timestamp']});
      }
    }

    doctorsWithMessages.sort((a, b) {
      return (b['timestamp'] as Timestamp)
          .compareTo(a['timestamp'] as Timestamp);
    });

    yield doctorsWithMessages.map((e) => e['doctor'] as DoctorModel).toList();
  }

  Stream<QuerySnapshot> getLastMessageStream(
      String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .limit(1)
        .snapshots();
  }

  updateNewMessage(String userId, String otherUserId, String messageId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .doc(messageId)
        .update({'newMessage': false});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DoctorModel>>(
      stream: streamDoctorsWithMessages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ShimmerMyAppointment());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error:::::::::::: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No doctors found'));
        } else {
          List<DoctorModel> doctors = snapshot.data!;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              DoctorModel doctor = doctors[index];
              return StreamBuilder<QuerySnapshot?>(
                stream: getLastMessageStream(
                  FirebaseAuth.instance.currentUser!.uid,
                  doctor.id.toString(),
                ),
                builder: (context, messageSnapshot) {
                  String lastMessage = '';
                  String lastMessageTime = '';
                  bool newMessage = false;
                  String senderId = '';
                  String messageId = '';

                  if (messageSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    lastMessage = 'Loading...';
                  } else if (messageSnapshot.hasData &&
                      messageSnapshot.data!.docs.isNotEmpty) {
                    var data = messageSnapshot.data!.docs.first.data()
                        as Map<String, dynamic>;
                    lastMessage = data['message'] ?? 'No message';
                    lastMessageTime = _formatTimestamp(data['timestamp']);
                    newMessage = data['newMessage'] ?? false;
                    senderId = data['senderId'] ?? '';
                    messageId = data['messageId'];
                  }

                  return Column(
                    children: [
                      const SizedBox(height: 5),
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 60,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/general.png",
                              image: doctor.profile.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        trailing: Text(lastMessageTime),
                        title: Text(" ${doctor.name} "),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: newMessage == true &&
                                  senderId !=
                                      FirebaseAuth.instance.currentUser!.uid
                              ? const Text(
                                  "New Message",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : Text(lastMessage),
                        ),
                        onTap: () {
                          updateNewMessage(
                              FirebaseAuth.instance.currentUser!.uid,
                              doctor.id.toString(),
                              messageId);
                          doctorController.currentdoc = doctor;
                          Get.to(() => ChatScreen(receiverDoctor: doctor))
                              ?.then((_) {
                            chatingController.hasUnreadMessageMap[doctor.id] =
                                false;
                            chatingController.update();
                          });
                        },
                      ),
                      const SizedBox(height: 5),
                      const Divider(thickness: 2),
                    ],
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
