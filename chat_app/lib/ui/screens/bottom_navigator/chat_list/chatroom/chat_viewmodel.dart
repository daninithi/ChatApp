import 'package:chat_app/core/others/base_viewmodel.dart';

import 'dart:async';
import 'dart:developer';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/core/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatViewmodel extends BaseViewmodel {
  StreamSubscription? _contactRequestSubscription;
  final ChatService _chatService;
  final UserModel _currentUser;
  final UserModel _receiver;

  StreamSubscription? _subscription;

  ChatViewmodel(this._chatService, this._currentUser, this._receiver) {
    getChatRoom();

    _subscription = _chatService.getMessages(chatRoomId).listen((messages) {
      _messages = messages.docs.map((e) => Message.fromMap(e.data())).toList();
      notifyListeners();
    });

    // Listen for incoming contact requests
    _contactRequestSubscription = DatabaseService()
        .listenContactRequests(_currentUser.uid!)
        .listen((snapshot) {
          for (var doc in snapshot.docs) {
            // If a request is found, show dialog
            final data = doc.data() as Map<String, dynamic>;
            if (data['status'] == 'pending') {
              // Use a callback to show dialog in UI
              onContactRequestReceived?.call(data, doc.id);
            }
          }
        });
  }
  // Callback to show dialog in UI
  void Function(Map<String, dynamic> request, String requestId)?
  onContactRequestReceived;

  String chatRoomId = "";

  final _messageController = TextEditingController();

  TextEditingController get controller => _messageController;

  List<Message> _messages = [];

  List<Message> get messages => _messages;

  getChatRoom() {
    if (_currentUser.uid.hashCode > _receiver.uid.hashCode) {
      chatRoomId = "${_currentUser.uid}_${_receiver.uid}";
    } else {
      chatRoomId = "${_receiver.uid}_${_currentUser.uid}";
    }
  }

  saveMessage() async {
    log("Send Message");
    try {
      if (_messageController.text.isEmpty) {
        throw Exception("Please enter some text");
      }
      final now = DateTime.now();

      final message = Message(
        id: now.millisecondsSinceEpoch.toString(),
        content: _messageController.text,
        senderId: _currentUser.uid,
        receiverId: _receiver.uid,
        timestamp: now,
      );

      await _chatService.saveMessage(message.toMap(), chatRoomId);

      _chatService.updateLastMessage(
        _currentUser.uid!,
        _receiver.uid!,
        message.content!,
        now.millisecondsSinceEpoch,
      );

      _messageController.clear();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _subscription?.cancel();
    _contactRequestSubscription?.cancel();
  }
}
