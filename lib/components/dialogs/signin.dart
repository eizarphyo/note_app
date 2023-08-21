import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app/network/user_api.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInDialog extends StatefulWidget {
  SignInDialog({super.key, required this.auth});

  AuthProvider auth;

  @override
  State<SignInDialog> createState() => _SignInDialogState();
}

class _SignInDialogState extends State<SignInDialog> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  _signIn() async {
    final Map user = {
      "username": _usernameCtrl.text,
      "password": _passwordCtrl.text
    };

    final jsonUser = json.encode(user);

    try {
      final Map resUser = await signInApi(jsonUser);
      widget.auth.uid = resUser['user']['_id'];

      debugPrint('$resUser');
      debugPrint('>>>> ${resUser['user']['_id']}');
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('uid', resUser['user']['_id']);
    } catch (err) {
      debugPrint('$err');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // height: MediaQuery.of(context).size.height * 0.25,
        // constraints: BoxConstraints(
        //   maxHeight: MediaQuery.of(context).size.height * 0.5,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Login to Your Account",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            TextField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(
                hintText: "Username",
              ),
            ),
            TextField(
              controller: _passwordCtrl,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  // show loading
                  _signIn();
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
