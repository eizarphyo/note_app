import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _uid;
  String? _token;
  late SharedPreferences prefs;

  bool _usernameErr = false;
  bool _passwordErr = false;

  String _nameErrMsg = '';
  String _passErrMsg = '';

  Future<SharedPreferences> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  // Future<String?> initAndGetUidWithPrefsUid() async {
  //   SharedPreferences prefs = await initPrefs();
  //   _uid = prefs.getString('uid');
  //   debugPrint("UID FROM PROVIDER >> $uid");
  //   return _uid;
  // }

  Future<String?> getTokenFromPrefs() async {
    SharedPreferences prefs = await initPrefs();
    _token = prefs.getString('token');
    debugPrint("TOKEN FROM PROVIDER >> $token");
    return _token;
  }

  setPrefsUid(String uid) async {
    SharedPreferences prefs = await initPrefs();
    prefs.setString('uid', uid);
  }

  setTokenInPrefs(String uid) async {
    SharedPreferences prefs = await initPrefs();
    prefs.setString('token', uid);
  }

  logout() async {
    SharedPreferences prefs = await initPrefs();

    prefs.clear();
    _token = null;
    notifyListeners();
  }

// GETTERS
  String? get uid => _uid;
  String? get token => _token;

  set token(String? value) {
    if (value != null) {
      _token = value;
      setTokenInPrefs(value);
      notifyListeners();
    }
  }

  bool get usernameErr => _usernameErr;
  bool get passwordErr => _passwordErr;

  String get nameErrMsg => _nameErrMsg;
  String get passErrMsg => _passErrMsg;

// SETTERS
  set uid(String? value) {
    if (value != null) {
      _uid = value;
      setPrefsUid(value);
      notifyListeners();
    }
  }

  // set token(String value) {
  //   _token = value;
  //   setTokenInPrefs(value);
  //   notifyListeners();
  // }

  set usernameErr(bool value) {
    _usernameErr = value;
    notifyListeners();
  }

  set passwordErr(bool value) {
    _passwordErr = value;
    notifyListeners();
  }

  set nameErrMsg(String value) {
    _nameErrMsg = value;
    notifyListeners();
  }

  set passErrMsg(String value) {
    _passErrMsg = value;
    notifyListeners();
  }
}
