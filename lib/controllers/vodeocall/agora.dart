// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';

// class VideoCallController extends GetxController {
//   final String appId = 'YOUR_AGORA_APP_ID';
//   final String token = 'YOUR_AGORA_TOKEN';
//   final String channelName = 'YOUR_CHANNEL_NAME';
//    int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;

//   @override
//   void onInit() {
//     super.onInit();
//     initializeAgora();
//   }

//   void initializeAgora() async {
//     await [Permission.microphone, Permission.camera].request();

//     RtcEngineContext context = RtcEngineContext(appId: appId);
//     await RtcEngine.createWithContext(context);
//     await RtcEngine.instance.enableVideo();

//     RtcEngine.instance.setEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (String channel, int uid, int elapsed) {
//           print('joinChannelSuccess $channel $uid');
//         },
//         onUserJoined: (int uid, int elapsed) {
//           print('userJoined $uid');
//         },
//         onUserOffline: (int uid, UserOfflineReason reason) {
//           print('userOffline $uid');
//         },
//       ),
//     );
//   }

//   void joinChannel() async {
//     await RtcEngine.instance.joinChannel(token, channelName, null, 0);
//   }

//   void leaveChannel() async {
//     await RtcEngine.instance.leaveChannel();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     RtcEngine.instance.destroy();
//   }
// }
