import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _fire = FirebaseFirestore.instance;

  Future<void> saveUser(Map<String, dynamic> userData) async {
    try {
      await _fire.collection('users').doc(userData['uid']).set(userData);
      log("user saved successfully: ${userData['uid']}");
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> loadUser(String uid) async {
    try {
      final res = await _fire.collection('users').doc(uid).get();
      if (res.data() != null) { 
        log("user fetched successfully: $uid");
        return res.data() as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Method to get all chat users for the current user (users with messages)
  Stream<QuerySnapshot> getChatUsers(String currentUserUid) {
    return _fire
        .collection('chats')
        .where('participants', arrayContains: currentUserUid)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }

  // Create an initial chat record between two users
  Future<void> createInitialChat(String user1Id, String user2Id) async {
    try {
      // Sort IDs to ensure consistent chat ID
      final List<String> sortedIds = [user1Id, user2Id]..sort();
      final String chatId = '${sortedIds[0]}_${sortedIds[1]}';

      // Create or update the chat document
      await _fire.collection('chats').doc(chatId).set({
        'participants': [user1Id, user2Id],
        'createdAt': FieldValue.serverTimestamp(),
        'lastMessageTime': FieldValue.serverTimestamp(),
        'lastMessage': null
      }, SetOptions(merge: true));

      log('Created initial chat between $user1Id and $user2Id');
    } catch (e) {
      log('Error creating initial chat: $e');
      rethrow;
    }
  }
}