import 'dart:async';
import 'dart:developer';
import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:flutter/material.dart';

class ChatListViewmodel extends ChangeNotifier {
  final DatabaseService _dbService;
  final UserModel _currentUser;
  StreamSubscription? _chatUsersSubscription;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<UserModel> _chatUsers = [];
  List<UserModel> get chatUsers => _chatUsers;

  ChatListViewmodel(this._dbService, this._currentUser) {
    _loadChatUsers();
  }

  void _loadChatUsers() {
    _setState(ViewState.loading);
    
    _chatUsersSubscription?.cancel();
    _chatUsersSubscription = _dbService.getChatUsers(_currentUser.uid!).listen((snapshot) async {
      _chatUsers.clear();
      for (var doc in snapshot.docs) {
        final userData = await _dbService.loadUser(doc.id);
        if (userData != null) {
          final user = UserModel.fromMap(userData);
          if (user.uid != _currentUser.uid) {
            _chatUsers.add(user);
          }
        }
      }
      notifyListeners();
      _setState(ViewState.idle);
    }, onError: (error) {
      _setState(ViewState.idle);
      log("Error fetching searched users: $error");
    });
  }

  void _setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  // Method to fetch a user by their ID
  @override
  void dispose() {
    _chatUsersSubscription?.cancel();
    super.dispose();
  }
}