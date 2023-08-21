import 'package:flutter/material.dart';
import 'package:note_app/network/note_api.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';

class DeleteNoteAlert extends StatefulWidget {
  DeleteNoteAlert({super.key, required this.id});

  late String id;

  @override
  State<DeleteNoteAlert> createState() => _DeleteNoteAlertState();
}

class _DeleteNoteAlertState extends State<DeleteNoteAlert> {
  late String uid;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    NoteProvider noteProvider = Provider.of<NoteProvider>(context);

    return AlertDialog(
      title: const Text("Delete Note"),
      content: const Text("Are you sure want to delete this note?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              uid = auth.uid!;
              _deleteNote(noteProvider);
              Navigator.pop(context);
            },
            child: const Text("Delete")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
      ],
    );
  }

  _deleteNote(NoteProvider provider) async {
    // call api and delete
    try {
      bool deleted = await deleteNoteApi(widget.id);
      if (deleted) {
        await provider.getNotes(uid);
      }
    } catch (err) {
      print(err);
    }
  }
}
