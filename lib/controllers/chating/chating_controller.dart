import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teledocuser/model/message/message_model.dart';

class ChatingController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var hasUnreadMessageMap = <String, bool>{}.obs;
  var lastMessages = <String, Message?>{}.obs;

  



  // get Last Message
  //************************************************************************** */


  Stream<Message?> getLastMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        Message message = Message.fromMap(querySnapshot.docs.first.data());

        lastMessages[otherUserId] = message;
        hasUnreadMessageMap[otherUserId] = true;
        return message;
      } else {
        return null;
      }
    });
  }




  // Mark as read
  //************************************************************************** */

  void markAsRead(String doctorId) {
    if (hasUnreadMessageMap.containsKey(doctorId)) {
      hasUnreadMessageMap[doctorId] = false;
    }
  }

  final Map<String, bool> isChatOpened = {};

  void markChatOpened(String doctorId) {
    isChatOpened[doctorId] = true;
  }

  void markChatClosed(String doctorId) {
    isChatOpened[doctorId] = false;
  }





  // Send Message
  //************************************************************************** */

  Future<void> sendMessage(String receiverId, String message) async {
    final currentUserId = _auth.currentUser!.uid;
    final currentuserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
     List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatroomId = ids.join("_");
     final  idtime=Timestamp.now().microsecondsSinceEpoch;

    Message newMessage = Message(
        messageId:"$chatroomId""_$idtime",
      newMessage: true,
        senderId: currentUserId,
        senderEmail: currentuserEmail,
        receverId: receiverId,
        message: message,
        timestamp: timestamp);

   

  await _fireStore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .doc("$chatroomId""_$idtime"). set(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
