import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';

class VideoCallScreenUikit extends StatefulWidget {
  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreenUikit> {
  final AgoraClient _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "ab0681cef04a45d089df7dd7e0cb144d", // Replace with your App ID
      channelName: "testingvideocall", // Replace with your channel name
      tempToken: "007eJxTYJA4/94lT3LB13tuj8K2Tz0j+046bRO/gnVRW7tfep75ZWUFhsQkAzMLw+TUNAOTRBPTFAMLy5Q085QU81SD5CRDE5OU9fvK0xoCGRlcKq4xMTJAIIgvwFCSWlySmZdelpmSmp+cmJPDwAAACEok8w==", // Replace with your token if you have it
    ),
  );

  @override
  void initState() {
    super.initState();
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
        title: const Text('Agora Video Call'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
              layoutType: Layout.floating,
              enableHostControls: true, // Add buttons for switching camera and mute
            ),
            AgoraVideoButtons(client: _client),
          ],
        ),
      ),
    );
  }
}
