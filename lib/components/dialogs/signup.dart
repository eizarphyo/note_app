import 'package:flutter/material.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/providers/loading_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../network/user_api.dart';

class SignUpDialog extends StatefulWidget {
  const SignUpDialog({super.key});

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  _signUp(AuthProvider auth, LoadingProvider loader) async {
    loader.loading = true;

    final objBody = <String, String>{
      "username": _usernameCtrl.text,
      "password": _passwordCtrl.text
    };

    debugPrint('objbody >>>>> $objBody');

    final jsonBody = json.encode(objBody);
    debugPrint('jsonbody >>>>>> $jsonBody');

    try {
      final response = await signUpApi(jsonBody);

      // auth.uid = response['user']['_id'];
      auth.uid = response['token'];
      Navigator.pop(context);
    } catch (err) {
      if (err == 409) {
        // namePassProvider.usernameErr = true;
        // namePassProvider.nameErrMsg = "Username already taken";
        setState(() {});
        debugPrint('shown error');
      } else {
        debugPrint('$err');
      }
    } finally {
      loader.loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    final LoadingProvider loader = Provider.of<LoadingProvider>(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Create An Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
            ),
            TextField(
              controller: _usernameCtrl,
              autofocus: true,
              onChanged: (val) {
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
              onChanged: (val) {
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
                              // show loading
                              _signUp(auth, loader);
                            },
                  child: const Text("Done")),
            )
          ],
        ),
      ),
    );
  }
}
