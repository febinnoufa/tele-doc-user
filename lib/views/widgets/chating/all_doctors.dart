import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/chating/chating_controller.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';
import 'package:teledocuser/model/message/message_model.dart';
import 'package:teledocuser/views/screens/chating/chat_screen.dart';

class ChatingShowAllDoctors extends StatelessWidget {
  ChatingShowAllDoctors({Key? key}) : super(key: key);

  final DoctorController doctorController = Get.put(DoctorController());
  final ChatingController chatingController = Get.put(ChatingController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DoctorModel>>(
      stream: doctorController.doctorStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No doctors found'));
        } else {
          final doctors = snapshot.data!;
          return StreamBuilder<List<DoctorModel>>(
            stream: _filterDoctorsWithChatHistory(doctors),
            builder: (context, filteredSnapshot) {
              if (filteredSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (filteredSnapshot.hasError) {
                return Center(child: Text('Error: ${filteredSnapshot.error}'));
              } else if (!filteredSnapshot.hasData || filteredSnapshot.data!.isEmpty) {
                return const Center(child: Text('No doctors found'));
              } else {
                final filteredDoctors = filteredSnapshot.data!;
                return ListView.builder(
                  itemCount: filteredDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = filteredDoctors[index];
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
                            height: 70,
                            child: doctor.profile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      doctor.profile!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                          ),
                          trailing: _buildLastMessageTime(doctor.id),
                          title: Text("Dr ${doctor.name}"),
                          subtitle: _buildLastMessageText(doctor.id),
                          onTap: () {
                            Get.to(() => ChatScreen(receiverDoctor: doctor))
                                ?.then((_) {
                              // Mark message as read
                              chatingController.hasUnreadMessageMap[doctor.id] = false;
                              // Refresh the UI
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
              }
            },
          );
        }

      },
    );
  }

  Stream<List<DoctorModel>> _filterDoctorsWithChatHistory(List<DoctorModel> doctors) async* {
    List<DoctorModel> filteredDoctors = [];

    for (var doctor in doctors) {
      final hasMessages = await chatingController.getMessages(
          FirebaseAuth.instance.currentUser!.uid, doctor.id).first;
      if (hasMessages.docs.isNotEmpty) {
        filteredDoctors.add(doctor);
      }
    }

    yield filteredDoctors;
  }

  Widget _buildLastMessageTime(String doctorId) {
    if (chatingController.lastMessages.containsKey(doctorId)) {
      Message? lastMessage = chatingController.lastMessages[doctorId];
      DateTime date = lastMessage!.timestamp.toDate();
      return Text(
        "${date.hour}:${date.minute.toString().padLeft(2, '0')}",
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildLastMessageText(String doctorId) {
    if (chatingController.lastMessages.containsKey(doctorId)) {
      Message? lastMessage = chatingController.lastMessages[doctorId];
      bool hasUnread = chatingController.hasUnreadMessageMap.containsKey(doctorId) &&
          chatingController.hasUnreadMessageMap[doctorId]!;
      return Text(
        hasUnread ? "New message" : lastMessage!.message,
        style: TextStyle(
          color: hasUnread ? Colors.black : Colors.grey,
          fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
        ),
      );
    } else {
      return const Text(
        "No messages yet",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
    }
  }
}
