// import 'dart:async';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:teledocuser/views/screens/review/review.dart';

// const appId = "842fdaf18994441f843efc88c021bd09";

// class VideoCallScreen extends StatefulWidget {
//   final String channel;
//   final String token;
//   final String uid; 

//   const VideoCallScreen({
//     Key? key,
//     required this.channel,
//     required this.token,
//     required this.uid,
//   }) : super(key: key);

//   @override
//   State<VideoCallScreen> createState() => _VideoCallScreenState();
// }

// class _VideoCallScreenState extends State<VideoCallScreen> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   bool _muted = false;
//   bool _videoMuted = false;
//   late RtcEngine _engine;

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   Future<void> initAgora() async {
//     await [Permission.microphone, Permission.camera].request();

//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(appId: appId));

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );

//     await _engine.enableVideo();
//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.startPreview();

//     await _engine.joinChannel(
//       token: widget.token,
//       channelId: widget.channel,
//       uid: int.parse(widget.uid),
//       options: const ChannelMediaOptions(),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _dispose();
//   }

//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }

//   void _onToggleMute() {
//     setState(() {
//       _muted = !_muted;
//     });
//     _engine.muteLocalAudioStream(_muted);
//   }

//   void _onToggleVideoMute() {
//     setState(() {
//       _videoMuted = !_videoMuted;
//     });
//     _engine.muteLocalVideoStream(_videoMuted);
//   }

//   void _onCallEnd(BuildContext context) {
//     _dispose();
//     Navigator.pop(context);
//   }

//   Widget _toolbar() {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           RawMaterialButton(
//             onPressed: _onToggleMute,
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: _muted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//             child: Icon(
//               _muted ? Icons.mic_off : Icons.mic,
//               color: _muted ? Colors.white : Colors.blueAccent,
//               size: 20.0,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () {
//               _onCallEnd(context);

//               Get.to(RatingScreen());
//             },
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.redAccent,
//             padding: const EdgeInsets.all(15.0),
//             child: const Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 35.0,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: _onToggleVideoMute,
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: _videoMuted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//             child: Icon(
//               _videoMuted ? Icons.videocam_off : Icons.videocam,
//               color: _videoMuted ? Colors.white : Colors.blueAccent,
//               size: 20.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _localVideo() {
//     if (_localUserJoined) {
//       return AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: _engine,
//           canvas: const VideoCanvas(uid: 0),
//         ),
//       );
//     } else {
//       return const CircularProgressIndicator();
//     }
//   }

//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: widget.channel),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for the remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Center(
//         child: Stack(
//           children: [
//             Center(
//               child: _remoteVideo(),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: SizedBox(
//                 width: 100,
//                 height: 150,
//                 child: Center(
//                   child: _localVideo(),
//                 ),
//               ),
//             ),
//             _toolbar(),
//           ],
//         ),
//       ),
//     );
//   }
// }
