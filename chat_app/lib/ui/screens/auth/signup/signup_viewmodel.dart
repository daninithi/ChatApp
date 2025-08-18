import 'dart:developer';
import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/others/base_viewmodel.dart';
import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/core/models/user.dart';

class SignUpViewModel extends BaseViewmodel {
  final AuthService _auth;
  final DatabaseService _db;
   String _email ;

  SignUpViewModel(this._auth, this._db, this._email);

  String _password = '';
  String _name = '';
  String _confirmPassword = ''; 

  // setEmail(String value) {
  //   _email = value;
  //   notifyListeners();
  //   log("Name: $_email"); // Log the email for debugging
  // } 

  setName(String value) {
    _name = value;
    notifyListeners();
    log("Email: $_name"); // Log the email for debugging
  } 

  setPassword(String value) {
    _password = value;
    notifyListeners();
    log("Password: $_password"); // Log the password for debugging
  }

  setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
    log("Confirm Password: $_confirmPassword"); // Log the confirm password for debugging
  }

  signup() async{
    setstate(ViewState.loading);
    try {
      if(_password == _confirmPassword) {
        throw Exception("Passwords do not match");
      }
      final res = await _auth.signup(_email, _password);
      if(res != null) {
        UserModel user = UserModel(uid: res.uid, name: _name, email: _email);
        await _db.saveUser(user.toMap());      }
      res.uid; // Ensure the user is created
     setstate(ViewState.idle);
    } on FirebaseAuthException catch (e) {
      setstate(ViewState.idle);
      rethrow;
    } catch (e) {
      setstate(ViewState.idle);
      log(e.toString());
      rethrow;
    }
  }
}