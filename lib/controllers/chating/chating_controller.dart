import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teledocuser/model/message/message_model.dart';

class ChatingController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var hasUnreadMessageMap = <String, bool>{}.obs;
  var lastMessages =
      <String, Message?>{}; // Map to store last message for each doctor

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

        // Update last message for the doctor
        lastMessages[otherUserId] = message;

        // Set unread status based on your logic
        hasUnreadMessageMap[otherUserId] =
            true; // Example: always show as unread for demo
        return message;
      } else {
        return null;
      }
    });
  }

  void markAsRead(String doctorId) {
    if (hasUnreadMessageMap.containsKey(doctorId)) {
      hasUnreadMessageMap[doctorId] = false;
    }
  }

  // Map to track which chat screens are opened for each doctor
  final Map<String, bool> isChatOpened = {};

  // Function to mark a chat screen as opened
  void markChatOpened(String doctorId) {
    isChatOpened[doctorId] = true;
  }

  // Function to mark a chat screen as closed
  void markChatClosed(String doctorId) {
    isChatOpened[doctorId] = false;
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final currentUserId = _auth.currentUser!.uid;
    final currentuserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentuserEmail,
        receverId: receiverId,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatroomId = ids.join("_");

    await _fireStore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .add(newMessage.toMap());
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
