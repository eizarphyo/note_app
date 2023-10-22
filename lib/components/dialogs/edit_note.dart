import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app/providers/loading_provider.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/note_api.dart';

class EditNoteDialog extends StatefulWidget {
  EditNoteDialog({super.key, required this.note});

  Map note = {};

  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  Map? editedNote;

  _editNote(NoteProvider provider, LoadingProvider loader) async {
    loader.loading = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final newNote = {
      "title": _titleCtrl.text,
      "content": _contentCtrl.text,
      "uid": widget.note['uid']
    };

    final String jsonNote = json.encode(newNote);

    try {
      editedNote = await editNoteApi(widget.note['_id'], jsonNote, token!);
      provider.recallApi();
    } catch (err) {
      print(err);
    } finally {
      loader.loading = false;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _titleCtrl.text = widget.note['title'];
      _contentCtrl.text = widget.note['content'];
    });
  }

  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context);

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      title: const Text("Edit Note"),
      content: Container(
        // height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.8,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleCtrl,
                autofocus: true,
                onChanged: (val) {
                  setState(() {});
                },
                decoration: const InputDecoration(border: InputBorder.none),
              ),
              const Divider(
                color: Colors.brown,
              ),
              TextField(
                controller: _contentCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (val) {
                  setState(() {});
                },
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(
            onPressed: _titleCtrl.text == "" && _contentCtrl.text == ""
                ? null
                : () {
                    _editNote(noteProvider, loadingProvider);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
            child: const Text("Edit")),
      ],
    );
  }
}
