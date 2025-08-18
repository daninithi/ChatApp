// lib/ui/screens/bottom_navigator/chat_list/chat_list_viewmodel.dart

import 'dart:developer';
import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:flutter/material.dart';

class ChatListViewmodel with ChangeNotifier {
  final DatabaseService _dbService;
  final UserModel _currentUser;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<UserModel> _chatUsers = [];
  List<UserModel> get chatUsers => _chatUsers;

  List<UserModel> _filteredUsers = [];
  List<UserModel> get filteredUsers => _filteredUsers;

  ChatListViewmodel(this._dbService, this._currentUser) {
    // You can listen to the searched contacts stream here to populate _chatUsers
    // This will automatically update the UI when a new user is searched
    _dbService.getSearchedUsers(_currentUser.uid!).listen((snapshot) async {
      _chatUsers.clear();
      for (var doc in snapshot.docs) {
        final userData = await _dbService.loadUser(doc.id);
        if (userData != null) {
          final user = UserModel.fromMap(userData);
          // Check if user is not the current user
          if (user.uid != _currentUser.uid) {
            _chatUsers.add(user);
          }
        }
      }
      _filteredUsers = _chatUsers;
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
  Future<void> fetchUserById(String uid) async {
    _setState(ViewState.loading);
    try {
      final userData = await _dbService.loadUser(uid);
      if (userData != null && uid != _currentUser.uid) {
        final user = UserModel.fromMap(userData);
        // Add the user to the list if not already present
        if (!_chatUsers.any((element) => element.uid == user.uid)) {
          _chatUsers.insert(0, user); // Add to the top of the list
          _filteredUsers.insert(0, user);
        }

        // Call the new database method to save the searched user
        await _dbService.saveSearchedUser(_currentUser.uid!, uid);
      } else {
        log("User not found or is current user");
      }
    } catch (e) {
      log("Error fetching user: $e");
      _setState(ViewState.idle);
    } finally {
      _setState(ViewState.idle);
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredUsers = _chatUsers;
    } else {
      _filteredUsers = _chatUsers
          .where((user) =>
              user.name!.toLowerCase().contains(query.toLowerCase()) ||
              user.uid!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}