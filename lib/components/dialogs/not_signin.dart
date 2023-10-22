import 'package:flutter/material.dart';
import 'package:note_app/components/dialogs/signin.dart';
import 'package:note_app/components/dialogs/signup.dart';
import 'package:note_app/providers/auth_provider.dart';

class NotSigninAlert extends StatefulWidget {
  const NotSigninAlert({super.key, required this.auth});

  final AuthProvider auth;

  @override
  State<NotSigninAlert> createState() => _NotSigninAlertState();
}

class _NotSigninAlertState extends State<NotSigninAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sign In First"),
      content: const Text("You need to sign in first to take notes."),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              // _showSignInDialog();
              _showDialog(SignInDialog(
                auth: widget.auth,
              ));
            },
            child: const Text("Sign In")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              // _showSignUpDialog();
              _showDialog(const SignUpDialog());
            },
            child: const Text("Sign Up")),
      ],
    );
  }

  _showDialog(Widget MyDialog) {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialog;
        });
  }
}
