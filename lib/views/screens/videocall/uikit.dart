import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';

class VideoCallScreenUikit extends StatefulWidget {
  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreenUikit> {
  late String token;
  // final DoctorController doctorController = Get.put(DoctorController());
  //late AgoraClient _client;

  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "ab0681cef04a45d089df7dd7e0cb144d",
      channelName: "teledoc",
      tempToken:
          "007eJxTYDD8frZlg6Rahqnu/QMzJSd1PcrawjFVn4F13+G7k5peCuYoMCQmGZhZGCanphmYJJqYphhYWKakmaekmKcaJCcZmpikBCytTmsIZGRYsj2HmZEBAkF8doaS1JzUlPxkBgYAshshAg==",
    ),
  );

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   token =
  //       '007eJxTYPA9oL9cIeFnbXvW3OpD4RweNm8EuD77HQ1s69A+9Mds/QUFhsQkAzMLw+TUNAOTRBPTFAMLy5Q085QU81SD5CRDE5MUdvHKtIZARobDV9KZGBkgEMRnZyhJLS7JzEtnYAAApxkgxQ==${doctorController.currentdoc.id}';
  //   _client = AgoraClient(
  //     agoraConnectionData: AgoraConnectionData(
  //       appId: "ab0681cef04a45d089df7dd7e0cb144d", // Replace with your App ID
  //       channelName: "teledoc", // Replace with your channel name
  //       tempToken: "007eJxTYDD8frZlg6Rahqnu/QMzJSd1PcrawjFVn4F13+G7k5peCuYoMCQmGZhZGCanphmYJJqYphhYWKakmaekmKcaJCcZmpikBCytTmsIZGRYsj2HmZEBAkF8doaS1JzUlPxkBgYAshshAg==",
  //     ),
  //   );
  //   _initAgora();
  // }

  Future<void> _initAgora() async {
    await client.initialize();
  }

  @override
  void dispose() {
    client.engine?.leaveChannel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: AgoraVideoViewer(
                client: client,
                layoutType: Layout.oneToOne,
                enableHostControls: true,
              ),
            ),
            AgoraVideoButtons(client: client),
          ],
        ),
      ),
    );
  }
}
