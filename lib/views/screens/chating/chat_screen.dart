// chat_screen.dart (User Side)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/chating/chating_controller.dart';
import 'package:teledocuser/controllers/review/review_rating.dart';
import 'package:teledocuser/controllers/vodeocall/token.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';
import 'package:teledocuser/views/screens/videocall/uikit.dart';

class ChatScreen extends StatefulWidget {
  final DoctorModel receiverDoctor;

  const ChatScreen({super.key, required this.receiverDoctor});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messagecontroller = TextEditingController();
  final ChatingController chatingcontroller = Get.put(ChatingController());
  final ScrollController _scrollController = ScrollController();
  final RatingController _controller = Get.put(RatingController());
  final VideoCallController cntr = Get.put(VideoCallController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    chatingcontroller.markAsRead(widget.receiverDoctor.id);
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 198, 198),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(widget.receiverDoctor.name),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _makePhoneCall(widget.receiverDoctor.phonenumber.toString());
              },
              icon: const Icon(Icons.phone)),
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () async {
              _controller.currentDoctorId.value = widget.receiverDoctor.id;

              await cntr.fetchToken();

              if (cntr.ifVideocall == true) {
                await cntr.initAgora();
                Get.to(VideoCallScreenUikit());
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: chatingcontroller.getMessages(widget.receiverDoctor.id.toString(),
          FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        }

        if (!snapshot.hasData) {
          return const Text("No Data");
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });

        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderId'] == FirebaseAuth.instance.currentUser!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            const Padding(padding: EdgeInsets.only(bottom: 4.0)),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(1, 2), blurRadius: 5)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(data['message'],
                      style: const TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 5),
                Text(
                  _formatTimestamp(data['timestamp']),
                  style: const TextStyle(color: Colors.grey, fontSize: 10.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messagecontroller,
                decoration: InputDecoration(
                  hintText: "Enter your message...",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
    void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await chatingcontroller.sendMessage(
          widget.receiverDoctor.id.toString(), _messagecontroller.text);

      _messagecontroller.clear();
      _scrollToBottom();
    }
  }

  void _makePhoneCall(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    if (res == null || !res) {}
  }
}
