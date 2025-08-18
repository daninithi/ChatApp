import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/others/base_viewmodel.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:flutter/material.dart';

class QRScanViewModel extends BaseViewmodel {
  final DatabaseService _db = DatabaseService();
  
  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  void setLoading(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  Future<UserModel?> processScanResult(String scannedUserId) async {
    try {
      setLoading(true);
      _isProcessing = true;
      notifyListeners();

      // Load user data from database
      final userData = await _db.loadUser(scannedUserId);
      if (userData != null) {
        final scannedUser = UserModel.fromMap(userData);
        return scannedUser;
      }
      return null;
    } catch (e) {
      debugPrint('Error processing QR scan: $e');
      return null;
    } finally {
      _isProcessing = false;
      setLoading(false);
      notifyListeners();
    }
  }
}