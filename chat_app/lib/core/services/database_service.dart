import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  // New method to create a temporary chat
  Future<void> createTemporaryChat(String currentUserUid, String scannedUserUid) async {
    try {
      // Create a unique chat ID by combining and sorting the UIDs
      List<String> userUids = [currentUserUid, scannedUserUid];
      userUids.sort(); // Sort to ensure the chat ID is consistent regardless of who scanned whom
      String chatId = userUids.join('_');

      // Check if a chat already exists to avoid duplication
      DocumentSnapshot chatDoc = await _fire.collection('temporary_chats').doc(chatId).get();

      if (!chatDoc.exists) {
        // Create the new temporary chat document
        await _fire.collection('temporary_chats').doc(chatId).set({
          'participants': [currentUserUid, scannedUserUid],
          'lastMessage': '',
          'lastMessageTimestamp': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        });
        log('Temporary chat created with ID: $chatId');
      } else {
        log('Temporary chat with ID: $chatId already exists.');
      }
    } catch (e) {
      log('Error creating temporary chat: $e');
      rethrow; // Re-throw the error so it can be caught in the ViewModel
    }
  }

  // You will also need a method to get the current user's UID
  String? getCurrentUserUid() {
    return _auth.currentUser?.uid;
  }


  // In your recent chats ViewModel or Page
  Stream<QuerySnapshot> getTemporaryChats(String currentUserId) {
    return FirebaseFirestore.instance
        .collection('temporary_chats')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots();
  }
}