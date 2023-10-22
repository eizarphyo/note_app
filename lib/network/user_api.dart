import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:note_app/utils/constants.dart';

const headers = {'Content-Type': 'application/json'};

Future<Map> signUpApi(body) async {
  const url = "$baseUrl/auth/signup";

  final uri = Uri.parse(url);

  var headers = {"Content-Type": "application/json"};

  final http.Response response =
      await http.post(uri, headers: headers, body: body);

  if (response.statusCode == 200) {
    final Map decodedJsonResponse = json.decode(response.body);

    debugPrint('decoded body >>>>> $decodedJsonResponse');

    return decodedJsonResponse;
  } else if (response.statusCode == 409) {
    // username already exist
    throw response.statusCode;
  } else {
    throw ("ERROR >>>>>> ${response.statusCode}");
  }
}

Future<Map> signInApi(body) async {
  const String signInUrl = "$baseUrl/auth/signin";

  final Uri uri = Uri.parse(signInUrl);

  final http.Response response =
      await http.post(uri, headers: headers, body: body);

  final decodedJson = json.decode(response.body);

  debugPrint('>>>>> $decodedJson');
  if (response.statusCode == 200) {
    return decodedJson;
  } else if (response.statusCode == 401) {
    // Wrong password
    throw (response.statusCode);
  } else if (response.statusCode == 404) {
    // Invalid username
    throw (response.statusCode);
  } else {
    throw ("ERRROR >>>> ${response.statusCode}");
  }
}
