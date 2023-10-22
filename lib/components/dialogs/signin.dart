import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app/network/user_api.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/loading_provider.dart';

class SignInDialog extends StatefulWidget {
  const SignInDialog({super.key, required this.auth});

  final AuthProvider auth;

  @override
  State<SignInDialog> createState() => _SignInDialogState();
}

class _SignInDialogState extends State<SignInDialog> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  _signIn(LoadingProvider loader) async {
    loader.loading = true;

    final Map user = {
      "username": _usernameCtrl.text,
      "password": _passwordCtrl.text
    };

    final jsonUser = json.encode(user);

    try {
      final Map resUser = await signInApi(jsonUser);
      // widget.auth.uid = resUser['user']['_id'];
      widget.auth.token = resUser['token'];

      debugPrint('$resUser');
      debugPrint('>>>> ${resUser['token']}');
    } catch (err) {
      debugPrint('$err');
    } finally {
      loader.loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final LoadingProvider loader = Provider.of<LoadingProvider>(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        // height: MediaQuery.of(context).size.height * 0.25,
        // constraints: BoxConstraints(
        //   maxHeight: MediaQuery.of(context).size.height * 0.5,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Login to Your Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
            ),
            TextField(
              controller: _usernameCtrl,
              autofocus: true,
              onChanged: (value) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            TextField(
              obscureText: true,
              controller: _passwordCtrl,
              onChanged: (value) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FilledButton(
                  onPressed:
                      _usernameCtrl.text == "" || _passwordCtrl.text == ""
                          ? null
                          : () {
                              Navigator.pop(context);
                              // show loading
                              _signIn(loader);
                            },
                  child: const Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}
