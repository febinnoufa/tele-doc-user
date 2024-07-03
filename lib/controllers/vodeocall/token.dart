import 'package:agora_uikit/agora_uikit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teledocuser/controllers/doctor/doctor_controller.dart';

class VideoCallController extends GetxController {
  RxBool ifVideocall = false.obs;
  final DoctorController dcController = Get.put(DoctorController());

  late AgoraClient client;
  final String appId = "ab0681cef04a45d089df7dd7e0cb144d";
  final String channelName = "test3";

  Future<String?> fetchToken() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('videocall')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();
      if (data != null && data['userId'] == dcController.currentdoc.id) {
        ifVideocall.value = true;
        return data['token'];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }



  Future<void> deleteToken() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('videocall').child(userId);

    try {
      await databaseReference.remove();
      print("Data for userId $userId has been deleted successfully.");
    } catch (e) {
      print("Error deleting data for userId $userId: $e");
    }
  }

  Future<void> initAgora() async {
    String? token = await fetchToken();
    if (token == null) {
      print("Error: Token is null");
      return;
    }
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: appId,
        channelName: channelName,
        tempToken: token,
      ),
    );
    await client.initialize();
    update();
  }

  @override
  void onClose() {
    client.engine.leaveChannel();
    super.onClose();
  }
}
