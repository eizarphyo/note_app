import 'package:flutter/material.dart';
import 'package:note_app/providers/auth_provider.dart';
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

  _signUp(AuthProvider auth) async {
    final objBody = <String, String>{
      "username": _usernameCtrl.text,
      "password": _passwordCtrl.text
    };

    debugPrint('objbody >>>>> $objBody');

    final jsonBody = json.encode(objBody);
    debugPrint('jsonbody >>>>>> $jsonBody');

    try {
      final response = await signUpApi(jsonBody);

      auth.uid = response['user']['_id'];

      // final SharedPreferences pres = await SharedPreferences.getInstance();
      // pres.setString("uid", "${response['user']['_id']}");

      Navigator.pop(context);

      // debugPrint("${response['user']['_id']}");
    } catch (err) {
      if (err == 409) {
        // namePassProvider.usernameErr = true;
        // namePassProvider.nameErrMsg = "Username already taken";
        setState(() {});
        debugPrint('shown error');
      } else {
        debugPrint('$err');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);

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
              "Create An Account",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            TextField(
              controller: _usernameCtrl,
              onTap: () {
                // if (namePassProvider.usernameErr) {
                //   namePassProvider.usernameErr = false;
                // }
              },
              decoration: InputDecoration(
                hintText: "Username",
                // errorText: namePassProvider.usernameErr
                //     ? namePassProvider.nameErrMsg
                //     : null
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
                  // show loading
                  _signUp(auth);
                },
                child: const Text("Done"))
          ],
        ),
      ),
    );
  }
}
