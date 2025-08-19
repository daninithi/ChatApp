import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Save a contact for a user
  Future<void> saveContact(
    String ownerUid,
    Map<String, dynamic> contactData,
  ) async {
    try {
      await _fire
          .collection('contacts')
          .doc(ownerUid)
          .collection('userContacts')
          .doc(contactData['uid'])
          .set(contactData);
      log("Contact saved for $ownerUid: ${contactData['uid']}");
    } catch (e) {
      rethrow;
    }
  }

  // Update contact request status
  Future<void> updateContactRequestStatus(
    String requestId,
    String status,
  ) async {
    try {
      await _fire.collection('contact_requests').doc(requestId).update({
        'status': status,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Send a contact request
  Future<void> sendContactRequest({
    required String senderUid,
    required String senderName,
    required String receiverUid,
  }) async {
    try {
      await _fire.collection('contact_requests').add({
        'senderUid': senderUid,
        'senderName': senderName,
        'receiverUid': receiverUid,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
      });
      log("Contact request sent from $senderUid to $receiverUid");
    } catch (e) {
      rethrow;
    }
  }

  // Listen for incoming contact requests for a user
  Stream<QuerySnapshot> listenContactRequests(String receiverUid) {
    return _fire
        .collection('contact_requests')
        .where('receiverUid', isEqualTo: receiverUid)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

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

  Future<List<Map<String, dynamic>>?> fetchUsers(String currentUserId) async {
    try {
      final res = await _fire
          .collection("users")
          .where("uid", isNotEqualTo: currentUserId)
          .get();

      return res.docs.map((e) => e.data()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
