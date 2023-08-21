import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:note_app/models.dart/note_model.dart';

Future<Map> createNoteApi(note) async {
  const createUrl = 'http://127.0.0.1:3000/noteapp/v1/notes';

  final uri = Uri.parse(createUrl);

  const headers = {'Content-Type': 'application/json'};

  final body = json.encode(note);

  final http.Response response =
      await http.post(uri, headers: headers, body: body);

  if (response.statusCode == 200) {
    final decodedRes = json.decode(response.body);

    return decodedRes;
  } else if (response.statusCode == 404) {
    // invalid username
    throw ("INVALID USERNAME >>>>>> ${response.statusCode}");
  } else if (response.statusCode == 401) {
    // Wrong password
    throw ("WRONG PASSWORD >>>>>> ${response.statusCode}");
  } else {
    throw ("ERROR >>>>>> ${response.statusCode}");
  }
}

Future<List> getAllNotes(String uid) async {
  final String url = "http://localhost:3000/noteapp/v1/notes/uid/$uid";
  final Uri uri = Uri.parse(url);

  final http.Response res = await http.get(uri);

  if (res.statusCode == 200) {
    final decodedJson = json.decode(res.body);

    List notes = decodedJson['notes'] ?? [];

    return notes;
  } else if (res.statusCode == 404) {
    // Invalid uid
    throw ("INVALID UID >>>> ${res.statusCode}");
  } else {
    throw ('ERROR >>> ${res.statusCode}');
  }
}

Future<bool> deleteNoteApi(String id) async {
  final deleteUrl = "http://localhost:3000/noteapp/v1/notes/$id";
  final uri = Uri.parse(deleteUrl);

  final http.Response res = await http.delete(uri);

  if (res.statusCode == 200) {
    return true;
  } else {
    throw ("ERROR >>> ${res.statusCode}");
  }
}
