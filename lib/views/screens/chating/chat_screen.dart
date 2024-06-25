// chat_screen.dart (User Side)
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:teledocuser/controllers/chating/chating_controller.dart';
import 'package:teledocuser/controllers/review/review_rating.dart';
import 'package:teledocuser/controllers/vodeocall/token.dart';
import 'package:teledocuser/model/doctor/doctor_model.dart';
import 'package:teledocuser/views/screens/videocall/uikit.dart';
import 'package:teledocuser/views/screens/videocall/video_call.dart';

import 'package:http/http.dart' as http;

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
      final TokenController tokenController = Get.put(TokenController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    chatingcontroller.markAsRead(widget.receiverDoctor.id);

    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: (receivedNotification) async {
    //     if (receivedNotification.channelKey == 'video_call_channel') {
    //       String channel = receivedNotification.payload!['channel']!;
    //       String token = receivedNotification.payload!['token']!;
    //       String callerId = receivedNotification.payload!['callerId']!;

    //       Get.to(() => VideoCallScreen(
    //             channel: channel,
    //             token: token,
    //             receiverDoctorId: widget.receiverDoctor.id.toString(),
    //           ));
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    AwesomeNotifications().cancelAllSchedules();
    super.dispose();
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

  // void _initiateVideoCall() async {
  //   await [Permission.microphone, Permission.camera].request();

  //   String channelId = 'some_unique_channel';
  //   String token = await generateAgoraToken(channelId);

  //   // await AwesomeNotifications().createNotification(
  //   //   content: NotificationContent(
  //   //     id: 1,
  //   //     channelKey: 'video_call_channel',
  //   //     title: 'Incoming Video Call',
  //   //     body:
  //   //         'You have an incoming video call from ${FirebaseAuth.instance.currentUser!.displayName}',
  //   //     payload: {
  //   //       'channel': channelId,
  //   //       'token': token,
  //   //       'callerId': FirebaseAuth.instance.currentUser!.uid
  //   //     },
  //   //     autoDismissible: false,
  //   //   ),
  //   //   actionButtons: [
  //   //     NotificationActionButton(
  //   //       key: 'ACCEPT',
  //   //       label: 'Accept',
  //   //       actionType: ActionType.Default,
  //   //     ),
  //   //     NotificationActionButton(
  //   //       key: 'DECLINE',
  //   //       label: 'Decline',
  //   //       actionType: ActionType.Default,
  //   //     ),
  //   //   ],
  //   // );

  //   Get.to(() => VideoCallScreen(
  //         channel: channelId,
  //         token: token,
  //         uid: widget.receiverDoctor,
  //       ));
  // }

  Future<String> generateAgoraToken(String channelName) async {
    // Replace with your backend server URL
    String apiUrl = 'https://your-backend-server.com/generate_token';

    // Make a GET request to fetch the token
    final response =
        await http.get(Uri.parse('$apiUrl?channelName=$channelName'));

    if (response.statusCode == 200) {
      return response.body; // Assuming your backend returns the token directly
    } else {
      throw Exception('Failed to load token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 198, 198),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text("${widget.receiverDoctor.name}"),
        centerTitle: true,
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading....");
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messagecontroller,
              decoration: const InputDecoration(
                hintText: "Enter your message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () async{
              _controller.currentDoctorId=widget.receiverDoctor.id;
              _controller.currentDoctorId=widget.receiverDoctor.name;
              _controller.currentDoctorId=widget.receiverDoctor.profile;
              print(">>>>>>>>>>>>>> ${_controller.currentDoctorId=widget.receiverDoctor.name}");
               //  tokenController.generateToken();
                 // print("!!!!!!!!!!!!!!!!!!!!!>>>>>>>>${tokenController. token.value}");
              await tokenController.sendtoken(widget.receiverDoctor.id, widget.receiverDoctor.name);
                
              Get.to(VideoCallScreenUikit());
              //_initiateVideoCall;
             // Get.to(VideoCallScreen(channel: "fluttering",token: "007eJxTYDiy8b7/NSbH+0+qM/ZMYp9YfbctQzDB9aznXPbG5vi2n38UGCxMjNJSEtMMLSwtTUxMDNMsTIxT05ItLJINjAyTUgwsHZuK0hoCGRmaEzMZGKEQxOdiSMspLSlJLcrMS2dgAABxECKa",uid: widget.receiverDoctor.id));
            },
          ),
        ],
      ),
    );
  }
}
