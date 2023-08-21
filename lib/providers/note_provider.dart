import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/note_api.dart';

class NoteProvider extends ChangeNotifier {
  List notes = [];
  String? _uid;

  Future<SharedPreferences> _initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<String?> _getUid() async {
    SharedPreferences prefs = await _initPrefs();
    String? uid = prefs.getString('uid');
    return uid;
  }

  getNotes(String uid) async {
    notes = await getAllNotes(uid);
    notifyListeners();
    return notes;
  }

  recallApi() async {
    String? uid = await _getUid();
    if (uid != null) {}
    notes = await getAllNotes(uid!);
    notifyListeners();
    return notes;
  }
}
