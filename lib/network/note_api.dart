import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:note_app/models.dart/note_model.dart';
import 'package:note_app/utils/constants.dart';

// const headers = {"Content-Type": "application/json"};

Future<Map> createNoteApi(Map note, String token) async {
  const createUrl = '$baseUrl/note';

  final uri = Uri.parse(createUrl);
  final headers = {
    'Content-Type': 'application/json',
    "Authorization": "Bearer $token"
  };

  final body = json.encode(note);

  final http.Response response = await http.post(
    uri,
    headers: headers,
    body: body,
  );

  final decodedRes = json.decode(response.body);

  if (response.statusCode == 200) {
    return decodedRes;
  } else if (response.statusCode == 404) {
    // invalid username
    throw ("INVALID USERNAME >>>>>> ${response.statusCode} | ${decodedRes['message']}");
  } else if (response.statusCode == 401) {
    // Wrong password
    throw ("WRONG PASSWORD >>>>>> ${response.statusCode} | ${decodedRes['message']}");
  } else {
    throw ("ERROR >>>>>> ${response.statusCode} | ${decodedRes['message']}");
  }
}

Future<List> getAllNotes(String token) async {
  const String url = "$baseUrl/note";
  final Uri uri = Uri.parse(url);
  final header = {"Authorization": "Bearer $token"};

  final http.Response res = await http.get(uri, headers: header);
  final decodedBody = json.decode(res.body);

  if (res.statusCode == 200) {
    List notes = decodedBody['notes'] ?? [];

    return notes;
  } else if (res.statusCode == 404) {
    // Invalid uid
    throw ("404 >>>> ${res.statusCode}");
  } else {
    throw ('ERROR >>> ${res.statusCode} | ${decodedBody['message']}');
  }
}

Future<bool> deleteNoteApi(String id, String token) async {
  final deleteUrl = "$baseUrl/note/$id";
  final uri = Uri.parse(deleteUrl);
  final headers = {"Authorization": "Bearer $token"};

  final http.Response res = await http.delete(uri, headers: headers);
  final decodedBody = json.decode(res.body);

  if (res.statusCode == 200) {
    return true;
  } else {
    throw ("ERROR >>> ${res.statusCode} | ${decodedBody['message']}");
  }
}

Future<Map> editNoteApi(String id, String body, String token) async {
  final editUrl = "$baseUrl/note/$id";
  final Uri uri = Uri.parse(editUrl);
  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token"
  };

  final http.Response res = await http.patch(uri, headers: headers, body: body);
  final decodedBody = json.decode(res.body);

  if (res.statusCode == 200) {
    // final decodedBody = json.decode(res.body);
    return decodedBody;
  } else {
    throw ("ERROR >>> ${res.statusCode} | ${decodedBody['message']}");
  }
}
