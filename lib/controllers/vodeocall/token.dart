import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';
import 'package:uuid/uuid.dart';

class TokenController extends GetxController {
  var token = ''.obs;
  var opositid;
  final DoctorController doctorController = Get.put(DoctorController());

  void generateToken() {
    var uuid = const Uuid();
    print("!!!!!!!!!!!!!!!!!!!!!>>>>>>>>${token.value}");
    token.value = uuid.v4();
  }

  sendtoken(receveid, name) async {
    FirebaseFirestore.instance.collection('videocall').doc(receveid).set({
      'token':
          '007eJxTYDD8frZlg6Rahqnu/QMzJSd1PcrawjFVn4F13+G7k5peCuYoMCQmGZhZGCanphmYJJqYphhYWKakmaekmKcaJCcZmpikBCytTmsIZGRYsj2HmZEBAkF8doaS1JzUlPxkBgYAshshAg==',
      'receveId': receveid,
      'receveName': name,
      'timestamp': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'userName': FirebaseAuth.instance.currentUser!.email!.split('@').first
    });
  }

  Future<CallData?> fetchCallData(String docId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('videocalls')
          .doc(docId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return CallData.fromJson(data!);
      } else {
        print('No call data found for ID: $docId');
        return null;
      }
    } catch (e) {
      print('Error fetching call data: $e');
      return null;
    }
  }
}

class CallData {
  final String callId;
  final String receiverId;
  final String receiverName;
  final Timestamp timestamp;
  final String userId;
  final String userName;
  final String status; // Optional for call status tracking

  CallData({
    required this.callId,
    required this.receiverId,
    required this.receiverName,
    required this.timestamp,
    required this.userId,
    required this.userName,
    this.status = '',
  });

  factory CallData.fromJson(Map<String, dynamic> json) => CallData(
        callId: json['callId'],
        receiverId: json['receiverId'],
        receiverName: json['receiverName'],
        timestamp: json['timestamp'],
        userId: json['userId'],
        userName: json['userName'],
        status: json['status'] ?? '', // Optional
      );
}
