import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final _fire = FirebaseFirestore.instance;

  saveMessage(Map<String, dynamic> message, String chatRoomId) async {
    try {
      await _fire
          .collection("chatRooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(message);
    } catch (e) {
      rethrow;
    }
  }

  updateLastMessage(
    String currentUid,
    String receiverUid,
    String message,
    int timestamp,
  ) async {
    try {
      await _fire.collection("users").doc(currentUid).update({
        "lastMessage": {
          "content": message,
          "timestamp": timestamp,
          "senderId": currentUid,
        },
        "unreadCounter": FieldValue.increment(1),
      });

      await _fire.collection("users").doc(receiverUid).update({
        "lastMessage": {
          "content": message,
          "timestamp": timestamp,
          "senderId": currentUid,
        },
      });

      // Also update lastMessage in temporary_chats
      final chatIdList = [currentUid, receiverUid]..sort();
      final chatIdStr = chatIdList.join('_');
      await _fire.collection('temporary_chats').doc(chatIdStr).update({
        'lastMessage': message,
        'lastMessageTimestamp': Timestamp.fromMillisecondsSinceEpoch(timestamp),
      });
    } catch (e) {
      rethrow;
    }
  }

  // New function to reset the unread counter when a user views the chat
  Future<void> resetUnreadCounter(String userUid) async {
    try {
      await _fire.collection("users").doc(userUid).update({"unreadCounter": 0});
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatRoomId) {
    return _fire
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
