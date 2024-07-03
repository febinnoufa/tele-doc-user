import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/vodeocall/token.dart';

class VideoCallScreenUikit extends StatefulWidget {
  const VideoCallScreenUikit({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoCallScreenState createState() => _VideoCallScreenState();



}

class _VideoCallScreenState extends State<VideoCallScreenUikit> {
  final VideoCallController cntr =Get.put(VideoCallController());
  bool _isCameraEnabled = true;
  bool _isMicEnabled = true;


    void offCamera() {
    setState(() {
      _isCameraEnabled = !_isCameraEnabled;
    });
   cntr.client.engine.muteLocalVideoStream(!_isCameraEnabled);
  }

  void toggleMic() {
    setState(() {
      _isMicEnabled = !_isMicEnabled;
    });
   cntr. client.engine.muteLocalAudioStream(!_isMicEnabled);
  }

  void switchCamera() {
   cntr. client.engine.switchCamera();
  }

  void leaveCall() async {

   cntr. client.engine.leaveChannel();
   cntr.ifVideocall.value=false;
    Navigator.of(context).pop(); 
  }

  // @override
  // void initState() {
  //   super.initState();
  //  cntr.initAgora();
  // }

  // Future<void> _initAgora() async {
  //   String? token = await cntr.fetchToken();
  //   if (token == null) {
  //     print("Error: Token is null");
  //     return;
  //   }
  //   client = AgoraClient(
  //     agoraConnectionData: AgoraConnectionData(
  //       appId: appId,
  //       channelName: channelName,
  //       tempToken: token,
  //     ),
  //   );
  //   await client.initialize();
  //   setState(() {});
  // }


  @override
  void dispose() {
    cntr.client.engine.leaveChannel();
    super.dispose();
  }

 Widget _buildControlButton(
      IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black54,
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: AgoraVideoViewer(
                client:cntr. client,
                layoutType: Layout.oneToOne,
                enableHostControls: true,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildControlButton(
                    _isCameraEnabled ? Icons.videocam : Icons.videocam_off,
                    Colors.white,
                    offCamera,
                  ),
                  const SizedBox(width: 20),
                  _buildControlButton(
                    _isMicEnabled ? Icons.mic : Icons.mic_off,
                    Colors.white,
                    toggleMic,
                  ),
                  const SizedBox(width: 20),
                  _buildControlButton(
                    Icons.switch_camera,
                    Colors.white,
                    switchCamera,
                  ),
                  const SizedBox(width: 20),
                  _buildControlButton(
                    Icons.call_end,
                    Colors.red,
                    leaveCall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
