import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/note_api.dart';

class NoteProvider extends ChangeNotifier {
  List notes = [];
  // String? _uid;
  String? _token;

  Future<SharedPreferences> _initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  // Future<String?> _getUid() async {
  //   SharedPreferences prefs = await _initPrefs();
  //   String? uid = prefs.getString('uid');
  //   return uid;
  // }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await _initPrefs();
    String? token = prefs.getString('token');
    return token;
  }

  Future<List> getNotes(String token) async {
    notes = await getAllNotes(token);
    notifyListeners();
    return notes;
  }

  recallApi() async {
    // String? uid = await _getUid();
    String? token = await _getToken();
    if (token != null) {}
    notes = await getAllNotes(token!);
    notifyListeners();
    return notes;
  }
}
