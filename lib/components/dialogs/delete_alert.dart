import 'package:flutter/material.dart';
import 'package:note_app/network/note_api.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/providers/loading_provider.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';

class DeleteNoteAlert extends StatefulWidget {
  DeleteNoteAlert({super.key, required this.id});

  late final String id;

  @override
  State<DeleteNoteAlert> createState() => _DeleteNoteAlertState();
}

class _DeleteNoteAlertState extends State<DeleteNoteAlert> {
  late String token;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context);

    return AlertDialog(
      title: const Text("Delete Note"),
      content: const Text("Are you sure want to delete this note?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              token = auth.token!;
              _deleteNote(noteProvider, loadingProvider);
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

  _deleteNote(NoteProvider provider, LoadingProvider loader) async {
    loader.loading = true;

    // call api and delete
    try {
      bool deleted = await deleteNoteApi(widget.id, token);
      if (deleted) {
        await provider.getNotes(token);
      }
    } catch (err) {
      print(err);
    } finally {
      loader.loading = false;
    }
  }
}
