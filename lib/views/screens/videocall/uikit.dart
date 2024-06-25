import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';

class VideoCallScreenUikit extends StatefulWidget {
  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreenUikit> {
  late String token;
  final DoctorController doctorController = Get.put(DoctorController());
  late AgoraClient _client;
  // = AgoraClient(
  //   agoraConnectionData: AgoraConnectionData(
  //     appId: "ab0681cef04a45d089df7dd7e0cb144d", // Replace with your App ID
  //     channelName: "testing", // Replace with your channel name
  //     tempToken: , // Replace with your token if you have it
  //   ),
  // );

  @override
  void initState() {
    super.initState();
    setState(() {
      token =
          '007eJxTYPA9oL9cIeFnbXvW3OpD4RweNm8EuD77HQ1s69A+9Mds/QUFhsQkAzMLw+TUNAOTRBPTFAMLy5Q085QU81SD5CRDE5MUdvHKtIZARobDV9KZGBkgEMRnZyhJLS7JzEtnYAAApxkgxQ==${doctorController.currentdoc.id}';
      _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
          appId: "ab0681cef04a45d089df7dd7e0cb144d", // Replace with your App ID
          channelName: "testing", // Replace with your channel name
          tempToken: token,
        ),
      );
    });
    _initAgora();
  }

  Future<void> _initAgora() async {
    await _client.initialize();
  }

  @override
  void dispose() {
    _client.engine?.leaveChannel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Video Call'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
              layoutType: Layout.floating,
              enableHostControls:
                  true, // Add buttons for switching camera and mute
            ),
            AgoraVideoButtons(client: _client),
          ],
        ),
      ),
    );
  }
}
