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

  // New method to save a searched user to a new collection
  Future<void> saveSearchedUser(String currentUserUid, String searchedUserUid) async {
    try {
      // You can use a subcollection for each user to store their searched contacts
      await _fire
          .collection('users')
          .doc(currentUserUid)
          .collection('searchedContacts')
          .doc(searchedUserUid)
          .set({'uid': searchedUserUid, 'timestamp': FieldValue.serverTimestamp()});
      log("Searched user $searchedUserUid saved for user $currentUserUid");
    } catch (e) {
      log("Error saving searched user: $e");
      rethrow;
    }
  }

  // New method to get all searched users for the current user
  Stream<QuerySnapshot> getSearchedUsers(String currentUserUid) {
    return _fire
        .collection('users')
        .doc(currentUserUid)
        .collection('searchedContacts')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

}